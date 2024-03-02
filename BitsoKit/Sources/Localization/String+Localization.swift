import Foundation

/// Improves the regular string to improve localization
public extension String {
    /// Localize without arguments.
    var localized: String {
        NSLocalizedString(self, comment: self)
    }

    /// Localize with format and arguments.
    /// - Parameters args: The variadic list of arguments to format the localized string.
    /// - Returns: The localized formatted string.
    func localize(_ args: CVarArg...) -> String {
        String(format: localized, arguments: args)
    }
}
