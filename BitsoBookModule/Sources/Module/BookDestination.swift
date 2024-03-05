import Foundation

/// Holds all the publicly `BookModule` destinations.
public enum BookDestination: Hashable {
    /// Navigate to the list of all available books.
    case bookList
}

/// Holds all the internal `BookModule` destinations.
enum BookInternalDestination: Hashable {
    /// Navigate to the detail page of a book.
    /// - Parameter id: The id of the book.
    case bookDetails(id: String)
}
