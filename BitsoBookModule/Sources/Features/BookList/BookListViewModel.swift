import Foundation

// MARK: - State

enum BookListState {
    case loading
    case empty
    case loaded(books: [BookListCardViewModel])
    case failed(error: BookServiceError)
}

// MARK: - Protocol

@MainActor
protocol BookListViewModel: ObservableObject {
    /// The current state of the view.
    var state: BookListState { get }

    /// Load all the available books.
    /// - Returns: The discardable task that will load the books.
    @discardableResult
    func loadBooks() -> Task<Void, Never>
}

// MARK: - Live

@MainActor
final class LiveBookListViewModel: BookListViewModel {

    // MARK: Published Properties

    @Published var state: BookListState = .loading

    // MARK: Private Properties

    private let service: any BookService

    // MARK: Initializers

    init(service: BookService) {
        self.service = service
    }

    // MARK: View Model Conformance

    @discardableResult
    func loadBooks() -> Task<Void, Never> {
        Task {
            let result = await service.fetchAll()
            switch result {
            case let .success(books) where books.isEmpty:
                state = .empty
            case let .success(books):
                let books = books.map { BookListCardViewModel(from: $0) }
                state = .loaded(books: books)
            case let .failure(failure):
                state = .failed(error: failure)
            }
        }
    }
}
