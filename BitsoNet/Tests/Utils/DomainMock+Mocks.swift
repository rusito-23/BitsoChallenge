import Foundation

extension DomainMock {
    /// Builds a domain with invalid path.
    static var invalid: DomainMock {
        DomainMock(
            scheme: "https",
            host: "host",
            path: "invalid path"
        )
    }

    /// Builds a domain with valid properties, without path.
    static var valid: DomainMock {
        DomainMock(
            scheme: "https",
            host: "api.site.com"
        )
    }
}
