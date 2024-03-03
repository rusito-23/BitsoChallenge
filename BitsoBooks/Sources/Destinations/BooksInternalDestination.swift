import Foundation

/// Holds all the internal destinations from `Books` module.
enum BooksInternalDestination {
    /// Navigate to the detail page of a book.
    /// - Parameter id: The id of the book.
    case bookDetail(id: String)
}
