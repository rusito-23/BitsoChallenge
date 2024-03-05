import Foundation

/// Holds common functionality that can be used across all book-related view models,
/// to prevent duplicating logic.
class BaseBookViewModel {
    /// Format the book name to be displayed.
    func displayName(from name: String) -> String {
        name.uppercased().split(separator: "_").joined(separator: " ")
    }

    /// Format as a currency a book-related value to be displayed.
    func currencyFormat(value: String) -> String {
        guard let double = Double(value) else { return value }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: double)) ?? value
    }
}
