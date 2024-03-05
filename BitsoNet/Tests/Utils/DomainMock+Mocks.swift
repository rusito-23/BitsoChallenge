import Foundation

extension DomainMock {
    /// Builds a environment with invalid path.
    static var invalid: DomainMock {
        DomainMock(
            scheme: "https",
            host: "host",
            path: "invalid path"
        )
    }

    /// Builds a environment with valid properties, without path.
    static var valid: DomainMock {
        DomainMock(
            scheme: "https",
            host: "api.site.com"
        )
    }
}
