import Foundation

/// The live implementation of the date provider.
public struct LiveDateProvider: DateProvider {
    /// Provides the current date.
    public func now() -> Date {
        Date()
    }
}
