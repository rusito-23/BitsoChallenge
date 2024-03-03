import Foundation

/// Describes the errors that can occur during ``BookService`` operations.
enum BookServiceError: Error {
    case generic
}

/// Describes  the requirements for the service that provides everything related to books.
protocol BookService {

    /// Retrieve all available books.
    /// - Returns: a result indicating whether the operation was successful and provides the list of books if available.
    func fetchAll() async -> Result<[Book], BookServiceError>

    /// Retrieve the details for a specific book.
    /// - Parameter id: The ID of the book to be retrieved.
    /// - Returns: a result indicating whether the operation was successful and provides the details of the book if available.
    func fetchDetails(with bookID: String) -> Result<Book, BookServiceError>
}
