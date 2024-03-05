import Foundation

/// Describes the components required to conform a environment, meant to be used to construct base URLs.
public protocol APIEnvironment {
    /// The schema used by the environment.
    /// Examples: _https_, _http_
    var scheme: String { get }

    /// The environment host of the environment.
    /// Examples: _www.site.com_
    var host: String { get }

    /// An optional path to be appended to the base URL, if present. Defaults to `nil`.
    var path: String? { get }
}

extension APIEnvironment {
    /// By default, the path will not be taken into account.
    var path: String? { nil }
}
