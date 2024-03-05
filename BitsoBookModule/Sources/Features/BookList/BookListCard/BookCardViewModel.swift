import Foundation

/// Models the view of the book list card.
/// Does not support reactive behavior because its purpose is to update elements within a list.
struct BookCardViewModel {
    let id: String
    let name: String
    let maximumValue: String
    let minimumValue: String
    let maximumPrice: String

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
