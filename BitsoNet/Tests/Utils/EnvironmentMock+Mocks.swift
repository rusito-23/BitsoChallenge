import Foundation

extension EnvironmentMock {
    /// Builds a environment with invalid path.
    static var invalid: EnvironmentMock {
        EnvironmentMock(
            scheme: "https",
            host: "host",
            path: "invalid path"
        )
    }

    /// Builds a environment with valid properties, without path.
    static var valid: EnvironmentMock {
        EnvironmentMock(
            scheme: "https",
            host: "api.site.com"
        )
    }
}
