import Foundation

/// The live RESTful implementation of the network client protocol.
///
/// - Note: All payloads used in this client will be coded into/from JSON.
struct LiveNetworkClient {

    // MARK: Private Properties

    private let baseURL: URL = URL(string: "https://sandbox.bitso.com/api/v3")! // FIXME: Inject!
    private let urlSession: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let defaultHeaders: [Header]

    // MARK: Initializer

    /// Create a live RESTful network client.
    /// - Parameter urlSession: The URL session that will be used to perform the requests. Defaults to the shared instance.
    /// - Parameter defaultHeaders: The collection of default headers to be used in all requests.
    /// - Parameter encoder: The JSON encoder that will be used to encode the request payloads.
    /// - Parameter decoder: The JSON decoder that will be used to decode the response payloads.
    init(
        urlSession: URLSession = .shared,
        defaultHeaders: [Header] = [HTTP.Headers.ContentType.json],
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.defaultHeaders = defaultHeaders
        self.encoder = encoder
        self.decoder = decoder
    }
}

// MARK: - Network Service Conformance

extension LiveNetworkClient: NetworkClient {
    func perform<ResponsePayload: Decodable>(
        _ endpoint: EndpointProvider
    ) async -> Result<ResponsePayload, ServiceError> {

        // Build the request for the service call.
        guard let request = makeRequest(from: endpoint) else {
            return .failure(.invalidRequest)
        }

        // Perform the task to retrieve the response data.
        guard
            let (data, response) = try? await urlSession.data(for: request),
            let response = response as? HTTPURLResponse
        else {
            return .failure(.unknown)
        }

        let status = HTTP.Status(response.statusCode)
        let responsePayload = try? decoder.decode(ResponsePayload.self, from: data)

        // Determine the result of the response and perform an early escape if needed.
        switch (status, responsePayload) {

        // Service determined that the request is invalid.
        case (.client, _):
            return .failure(.invalidRequest)

        // If the call is successful but we're missing the expected payload.
        case (.success, nil):
            return .failure(.invalidResponse)

        // There has been a server error.
        case (.server, _):
            return .failure(.serviceError(code: response.statusCode))

        // These status won't be handled at the moment.
        case (.info, _), (.redirect, _), (.unknown, _):
            return .failure(.unknown)

        // If the call is successful and we get the expected payload.
        case let (.success, .some(responsePayload)):
            return .success(responsePayload)
        }
    }
}

// MARK: - Private Utils

private extension LiveNetworkClient {
    /// Create the URL including the base URL, the path and the query parameters.
    func makeURL(from endpoint: EndpointProvider) -> URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.parameters
        return urlComponents?.url
    }

    /// Create the request based on the network call details.
    func makeRequest(from endpoint: EndpointProvider) -> URLRequest? {
        // Build the request URL.
        guard let url = makeURL(from: endpoint) else {
            return nil
        }

        // Create the request.
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        // Include request headers, prioritizing additional over default headers.
        let headers = [defaultHeaders, endpoint.additionalHeaders].compactMap { $0 }.joined()
        let rawHeaders = Dictionary(uniqueKeysWithValues: headers.map { ($0.key, $0.value) })
        request.allHTTPHeaderFields = rawHeaders

        // Include the payload in the request if supported and needed.
        if endpoint.method.supportsPayload, let payload = endpoint.requestPayload {
            guard let payloadData = try? encoder.encode(payload) else {
                return nil
            }
            request.httpBody = payloadData
        }

        return request
    }
}
