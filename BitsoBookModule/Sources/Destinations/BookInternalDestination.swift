import Foundation

/// Holds all the internal `BookModule` destinations.
enum BookInternalDestination {
    /// Navigate to the detail page of a book.
    /// - Parameter id: The id of the book.
    case bookDetail(id: String)
}
