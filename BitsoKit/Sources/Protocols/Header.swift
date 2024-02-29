import Foundation

/// Describes the components needed to construct a header.
public protocol Header {
    var key: String { get }
    var value: String { get }
}

public extension Header where Self: RawRepresentable, Self.RawValue == String {
    /// By default, String enums will define its rawValue as the value.
    var value: String { rawValue }
}
