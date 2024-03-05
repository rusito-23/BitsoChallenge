import Foundation

/// Holds common functionality that can be used across all book-related view models,
/// to prevent duplicating logic.
class BaseBookViewModel {
    /// Format the book name to be displayed.
    func displayName(from name: String) -> String {
        name.uppercased().split(separator: "_").joined(separator: " ")
    }

    /// Format as a currency a book-related value to be displayed.
    /// - Note: I'm not sure if we want to lose the decimal digits, so I'm using a custom format instead of `NumberFormatter`.
    /// - Note: Uses the current device locale instead of the `Book` locale (based on Minor).
    func currencyFormat(value: String, locale: Locale = .current) -> String {
        let negativeSign = "-"
        let currencySymbol = locale.currencySymbol ?? ""
        let rawValue = value.split(separator: negativeSign).first ?? ""
        return value.starts(with: negativeSign) ?
            "\(negativeSign)\(currencySymbol)\(rawValue)" :
            "\(currencySymbol)\(rawValue)"
    }
}
