import Foundation

extension URLSession {
    /// Provides the mock version of the `URLSession`, using `URLProtocolMock` as protocol class.
    static var mocked: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: configuration)
    }
}
