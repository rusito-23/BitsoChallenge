import Foundation

/// Any content that can be localized.
public protocol LocalizableContent {
    /// Localize without arguments.
    var localized: String { get }

    /// Localize with format and arguments.
    /// - Parameters args: The variadic list of arguments to format the localized string.
    /// - Returns: The localized formatted string.
    func localize(_ args: CVarArg...) -> String
}

// MARK: - Defaults

public extension LocalizableContent {
    /// By default, localization with arguments can be made with the existing localized value.
    func localize(_ args: CVarArg...) -> String {
        String(format: localized, arguments: args)
    }
}
