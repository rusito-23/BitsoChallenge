import BitsoNet
import Foundation

/// A mock endpoint that can take any values.
struct EndpointMock: Endpoint {
    let method: HTTP.Method
    let path: String
    let parameters: [URLQueryItem]
    let additionalHeaders: [Header]
    let requestPayload: Encodable?

    init(
        method: HTTP.Method = .get,
        path: String = "",
        parameters: [URLQueryItem] = [],
        additionalHeaders: [Header] = [],
        requestPayload: Encodable? = nil
    ) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.additionalHeaders = additionalHeaders
        self.requestPayload = requestPayload
    }
}
