import BitsoNet
@testable import BitsoBookModule

final class BookServiceMock: BookService {
    var bookListResult: Result<[Book], NetworkError>
    var bookDetailsResult: Result<BookDetails, NetworkError>

    init(
        bookListResult: Result<[Book], NetworkError> = .failure(.unknown),
        bookDetailsResult: Result<BookDetails, NetworkError> = .failure(.unknown)
    ) {
        self.bookListResult = bookListResult
        self.bookDetailsResult = bookDetailsResult
    }

    func fetchAll() async -> Result<[Book], NetworkError> {
        bookListResult
    }

    func fetchDetails(with bookID: String) async -> Result<BookDetails, NetworkError> {
        bookDetailsResult
    }
}
