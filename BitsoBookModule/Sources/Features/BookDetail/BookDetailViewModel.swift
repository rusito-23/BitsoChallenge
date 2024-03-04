import BitsoKit
import Foundation

// MARK: - State

enum BookDetailState {
    case loading
    case loaded
    case failed(error: BookServiceError)
}

// MARK: - Protocol

@MainActor
protocol BookDetailViewModel: ObservableObject {
    /// The current state of the view.
    var state: BookDetailState { get }

    /// Loads the details for the book.
    /// - Returns: The discardable task that will perform the load.
    @discardableResult
    func load() -> Task<Void, Never>
}

// MARK: - Live

@MainActor
final class LiveBookDetailViewModel: BookDetailViewModel {

    // MARK: Published Properties

    @Published private(set) var state: BookDetailState = .loading

    // MARK: Private Properties

    private let bookID: String
    private let service: BookService

    // MARK: Initializer

    init(bookID: String, service: BookService) {
        self.bookID = bookID
        self.service = service
    }

    // MARK: View Model Conformance

    @discardableResult
    func load() -> Task<Void, Never> {
        Task {
            let result = await service.fetchDetails(with: bookID)
            switch result {
            case .success:
                break
            case let .failure(error):
                state = .failed(error: error)
            }
        }
    }
}
