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
        name: String,
        maximumValue: String,
        minimumValue: String,
        maximumPrice: String
    ) {
        self.id = name
        self.name = name
        self.maximumValue = maximumValue
        self.minimumValue = minimumValue
        self.maximumPrice = maximumPrice
    }

    init(from book: Book) {
        self.id = book.name
        self.name = book.name.uppercased().split(separator: "_").joined(separator: " ")
        self.maximumValue = book.maximumValue
        self.minimumValue = book.minimumValue
        self.maximumPrice = book.maximumPrice
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
