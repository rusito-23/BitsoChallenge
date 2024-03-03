import BitsoKit
import Foundation

// TBD:
// - add retry system
// - add logger

/// The live RESTful implementation of the network client protocol.
///
/// - Note: All payloads used in this client will be coded into/from JSON.
public final class LiveNetworkClient {

    // MARK: Private Properties

    private let domain: Domain
    private let urlSession: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let defaultHeaders: [Header] = [HTTP.Headers.ContentType.json]

    // MARK: Initializer

    /// Create a live RESTful network client.
    /// - Parameter domain: The required domain for the network call.
    /// - Parameter urlSession: The URL session that will be used to perform the requests. Defaults to the shared instance.
    /// - Parameter encoder: The JSON encoder that will be used to encode the request payloads.
    /// - Parameter decoder: The JSON decoder that will be used to decode the response payloads.
    public init(
        domain: Domain,
        urlSession: URLSession = .shared,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.domain = domain
        self.urlSession = urlSession
        self.encoder = encoder
        self.decoder = decoder
    }
}

// MARK: - Network Service Conformance

extension LiveNetworkClient: NetworkClient {
    public func perform<ResponsePayload: Decodable>(
        _ endpoint: Endpoint
    ) async -> Result<ResponsePayload, ServiceError> {

        // Build the request for the service call.
        guard let request = makeRequest(from: endpoint) else {
            log.error("Request creation for \(endpoint.method) \(endpoint.path) failed.")
            return .failure(.invalidRequest)
        }

        // Perform the task to retrieve the response data.
        guard
            let (data, response) = try? await urlSession.data(for: request),
            let response = response as? HTTPURLResponse
        else {
            log.error("REQ: \(request) failed with unknown URLSession error.")
            return .failure(.unknown)
        }

        let status = HTTP.Status(response.statusCode)
        let responsePayload = try? decoder.decode(ResponsePayload.self, from: data)

        // Determine the result of the response and perform an early escape if needed.
        switch (status, responsePayload) {

        // Service determined that the request is invalid.
        case (.client, _):
            log.error("Request: \(request) failed with error: .invalidRequest")
            return .failure(.invalidRequest)

        // If the call is successful but we're missing the expected payload.
        case (.success, nil):
            log.error("Request: \(request) failed with error: .invalidResponse")
            return .failure(.invalidResponse)

        // There has been a server error.
        case (.server, _):
            log.error("Request: \(request) failed with error: .serviceError")
            return .failure(.serviceError(code: response.statusCode))

        // These status won't be handled at the moment.
        case (.info, _), (.redirect, _), (.unknown, _):
            log.error("Request: \(request) failed for status: \(status)")
            return .failure(.unknown)

        // If the call is successful and we get the expected payload.
        case let (.success, .some(responsePayload)):
            log.info("Request: \(request) succeeded.")
            return .success(responsePayload)
        }
    }
}

// MARK: - Private Utils

private extension LiveNetworkClient {
    /// Create the URL including the base URL, the path and the query parameters.
    func makeURL(from endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = domain.scheme
        urlComponents.host = domain.host
        urlComponents.path = domain.path ?? ""
        urlComponents.queryItems = endpoint.parameters
        return urlComponents.url?.appendingPathExtension(endpoint.path)
    }

    /// Create the request based on the network call details.
    func makeRequest(from endpoint: Endpoint) -> URLRequest? {
        // Build the request URL.
        guard let url = makeURL(from: endpoint) else {
            return nil
        }

        // Create the request.
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        // Include request headers, prioritizing additional over default headers.
        let headers = [defaultHeaders, endpoint.additionalHeaders].joined().map(\.asTuple)
        let rawHeaders = Dictionary(headers, uniquingKeysWith: { _, last in last })
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
