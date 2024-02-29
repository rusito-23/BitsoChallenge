import Foundation

/// Describes the required data to make a request to an endpoint.
public protocol EndpointProvider {
    /// The ``HTTPMethod`` for the service call.
    var method: HTTP.Method { get }

    /// The **path** to the resource that we want to perform the request over.
    var path: String { get }

    /// The query parameters to be included in the URL.
    var parameters: [URLQueryItem] { get }

    /// The optional request additional headers.
    var additionalHeaders: [Header]? { get }

    /// The request body payload.
    var requestPayload: Encodable? { get }
}
