import BitsoKit
import BitsoUI
import Foundation

// MARK: - State

enum BookListState {
    case loading
    case loaded(books: [BookCardViewModel])
    case failed(notice: NoticeViewModel)
}

// MARK: - Protocol

@MainActor
protocol BookListViewModeling: ObservableObject {
    /// The navigation title of the view.
    var title: String { get }

    /// The current state of the view.
    var state: BookListState { get }

    /// Starts the periodic reloading of the view model.
    func startPeriodicReload()

    /// Load all the available books.
    /// - Returns: The discardable task that will load the books.
    @discardableResult
    func loadBooks() -> Task<Void, Never>
}

// MARK: - View Model

@MainActor
final class BookListViewModel: BaseBookViewModel, BookListViewModeling {
    @Published private(set) var title: String = Content.title.localized
    @Published private(set) var state: BookListState = .loading

    private let service: any BookService
    private var timer: Timer?

    init(service: BookService) {
        self.service = service
    }

    deinit {
        timer?.invalidate()
    }

    func startPeriodicReload() {
        // Start a 30 second timer that will repeatedly reload the books and update the state.
        timer = .scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            // The operation needs to run in the main thread to ensure
            // the view model properties are available to be updated.
            Task { @MainActor [weak self] in
                log.info("Reload timer triggered on state: \(String(describing: self?.state))")
                guard let self, case .loaded = self.state else { return }
                self.loadBooks()
            }
        }
    }

    @discardableResult
    func loadBooks() -> Task<Void, Never> {
        Task {
            state = .loading
            let result = await service.fetchAll()
            switch result {
            case .failure:
                let notice = NoticeViewModel(
                    icon: .magnifyingGlass,
                    title: Content.noticeTitle.localized,
                    message: Content.generalErrorMessage.localized
                )
                state = .failed(notice: notice)

            case let .success(books) where books.isEmpty:
                let notice = NoticeViewModel(
                    icon: .magnifyingGlass,
                    title: Content.noticeTitle.localized,
                    message: Content.emptyResultsMessage.localized
                )
                state = .failed(notice: notice)

            case let .success(books):
                let books = books.map { book in
                    BookCardViewModel(
                        id: book.name,
                        name: displayName(from: book.name),
                        maximumValue: currencyFormat(value: book.maximumValue),
                        minimumValue: currencyFormat(value: book.minimumValue),
                        maximumPrice: currencyFormat(value: book.maximumPrice)
                    )
                }
                state = .loaded(books: books)
            }
        }
    }
}

// MARK: - Localizable Content

private extension BookListViewModel {
    enum Content: String, LocalizableContent {
        case title = "BOOK_LIST_TITLE"
        case noticeTitle = "OOPS"
        case emptyResultsMessage = "EMPTY_RESULT_MESSAGE"
        case generalErrorMessage = "GENERAL_ERROR_MESSAGE"

        var localized: String {
            localize(bundle: .module)
        }
    }
}
