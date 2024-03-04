import Foundation

/// Any enum that provides a string raw value can be localized.
public extension LocalizableContent where Self: RawRepresentable, Self.RawValue == String {
    func localize(bundle: Bundle) -> String {
        NSLocalizedString(rawValue, bundle: bundle, comment: rawValue)
    }
}
