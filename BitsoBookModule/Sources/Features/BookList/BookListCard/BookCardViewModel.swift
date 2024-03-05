import BitsoKit
import Foundation

/// Models the view of the book list card.
/// Does not support reactive behavior because its purpose is to update elements within a list.
struct BookCardViewModel {
    let id: String
    let name: String
    let maximumValue: String
    let minimumValue: String
    let maximumPrice: String
    var minimumLabel: String { Content.minimum.localized }
    var maximumLabel: String { Content.maximum.localized }

    init(
        id: String,
        name: String,
        maximumValue: String,
        minimumValue: String,
        maximumPrice: String
    ) {
        self.id = id
        self.name = name
        self.maximumValue = maximumValue
        self.minimumValue = minimumValue
        self.maximumPrice = maximumPrice
    }
}

// MARK: - Localizable Content

extension BookCardViewModel {
    enum Content: String, LocalizableContent {
        case minimum = "MINIMUM_VALUE_LABEL"
        case maximum = "MAXIMUM_VALUE_LABEL"

        var localized: String {
            localize(bundle: .module)
        }
    }
}
