import Foundation

/// Describes the components required to conform a domain, meant to be used to construct base URLs.
public protocol DomainProvider {
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

extension DomainProvider {
    var path: String? { nil }
}
