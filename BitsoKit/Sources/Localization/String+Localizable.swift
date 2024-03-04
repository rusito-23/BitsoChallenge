import Foundation

/// Any string can be localized.
extension String: LocalizableContent {
    public var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
