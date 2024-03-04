import Foundation

/// Any content that can be localized.
public protocol LocalizableContent {
    /// Localize without arguments.
    /// - Parameter bundle: The bundle in which the string is localized.
    func localize(bundle: Bundle) -> String

    /// Localize with format and arguments.
    /// - Parameter bundle: The bundle in which the string is localized.
    /// - Parameters args: The variadic list of arguments to format the localized string.
    /// - Returns: The localized formatted string.
    func localize(bundle: Bundle, _ args: CVarArg...) -> String
}

// MARK: - Defaults

public extension LocalizableContent {
    /// By default, we use the main bundle.
    func localize() -> String {
        localize(bundle: .main)
    }

    /// By default, localization with arguments can be made with the existing localized value.
    func localize(bundle: Bundle, _ args: CVarArg...) -> String {
        String(format: localize(bundle: bundle), arguments: args)
    }
}
