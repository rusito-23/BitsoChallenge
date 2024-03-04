import Foundation

/// Any enum that provides a string raw value can be localized.
public extension LocalizableContent where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        rawValue.localized
    }
}
