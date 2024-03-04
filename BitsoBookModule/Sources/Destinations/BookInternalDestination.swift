import Foundation

/// Holds all the internal `BookModule` destinations.
enum BookInternalDestination: Hashable {
    /// Navigate to the detail page of a book.
    /// - Parameter id: The id of the book.
    case bookDetails(id: String)
}
