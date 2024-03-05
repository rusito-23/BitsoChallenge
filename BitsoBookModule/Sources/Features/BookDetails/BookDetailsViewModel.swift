import BitsoKit
import Foundation

// MARK: - State

enum BookDetailsViewState {
    case loading
    case loaded(sections: [Section])
    case failed(error: BookServiceError)

    enum Section: Hashable {
        case history(volume: String, high: String, change: String)
        case bid(ask: String, bid: String)
    }
}

// MARK: - Protocol

@MainActor
protocol BookDetailsViewModel: ObservableObject {
    /// The title of the view. Updates to display the name of the book once loaded.
    var title: String? { get }

    /// The current state of the view.
    var state: BookDetailsViewState { get }

    /// Loads the details for the book.
    /// - Returns: The discardable task that will perform the load.
    @discardableResult
    func load() -> Task<Void, Never>
}

// MARK: - Live

@MainActor
final class LiveBookDetailsViewModel: BookDetailsViewModel {

    // MARK: Published Properties

    @Published private(set) var title: String?
    @Published private(set) var state: BookDetailsViewState = .loading

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
            case let .success(details):
                title = details.name
                state = .loaded(sections: [
                    .history(
                        volume: details.volume,
                        high: details.high,
                        change: details.change
                    ),
                    .bid(
                        ask: details.ask,
                        bid: details.bid
                    ),
                ])
            case let .failure(error):
                state = .failed(error: error)
            }
        }
    }
}
