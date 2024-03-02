import Foundation

extension EndpointMock {
    /// Retrieve the URL from the endpoint.
    var url: URL? {
        var components = URLComponents()
        components.scheme = domain.scheme
        components.host = domain.host
        components.path = domain.path ?? ""
        components.queryItems = parameters
        return components.url?.appendingPathExtension(path)
    }
}
