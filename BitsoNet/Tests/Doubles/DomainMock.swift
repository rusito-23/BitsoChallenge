import BitsoNet
import Foundation

/// A mock environment that can take any values.
struct DomainMock: APIEnvironment {
    let scheme: String
    let host: String
    let path: String?

    init(
        scheme: String,
        host: String,
        path: String? = nil
    ) {
        self.scheme = scheme
        self.host = host
        self.path = path
    }
}
