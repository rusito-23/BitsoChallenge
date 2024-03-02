import Foundation

/// Describes the components that conform a domain, meant to be used to construct base URLs.
public protocol Domain {
    /// The schema used by the domain.
    /// Examples: _https_, _http_
    var scheme: String { get }

    /// The host of the domain.
    /// Examples: _www.site.com_
    var host: String { get }

    /// An optional path to be appended to the base URL, if present. Defaults to `nil`.
    var path: String? { get }
}

// MARK: - Defaults

extension Domain {
    var path: String? { nil }
}
