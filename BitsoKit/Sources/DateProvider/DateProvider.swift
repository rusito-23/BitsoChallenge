import Foundation

/// A wrapper to provide dates.
public protocol DateProvider {
    /// Provides the current date.
    func now() -> Date
}
