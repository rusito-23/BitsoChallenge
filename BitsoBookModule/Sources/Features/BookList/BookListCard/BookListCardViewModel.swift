import Foundation

/// Models the view of the book list card.
/// Does not support reactive behavior because its purpose is to update elements within a list.
struct BookListCardViewModel {

    // MARK: Properties

    let name: String
    let maximumValue: String
    let minimumValue: String
    let maximumPrice: String

    // MARK: Initializer

    init(
        name: String,
        maximumValue: String,
        minimumValue: String,
        maximumPrice: String
    ) {
        self.name = name
        self.maximumValue = maximumValue
        self.minimumValue = minimumValue
        self.maximumPrice = maximumPrice
    }

    init(from book: Book) {
        name = book.book.uppercased()
        maximumValue = book.maximumValue
        minimumValue = book.minimumValue
        maximumPrice = book.maximumPrice
    }
}
