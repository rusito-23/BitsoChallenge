import BitsoKit
import Foundation

/// A mock endpoint that can take any values.
struct EndpointMock: Endpoint {
    let domain: Domain
    let method: HTTP.Method
    let path: String
    let parameters: [URLQueryItem]
    let additionalHeaders: [Header]
    let requestPayload: Encodable?

    init(
        domain: Domain = DomainMock.valid,
        method: HTTP.Method = .get,
        path: String = "",
        parameters: [URLQueryItem] = [],
        additionalHeaders: [Header] = [],
        requestPayload: Encodable? = nil
    ) {
        self.domain = domain
        self.method = method
        self.path = path
        self.parameters = parameters
        self.additionalHeaders = additionalHeaders
        self.requestPayload = requestPayload
    }
}
