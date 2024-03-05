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

    init(service: BookService) {
        self.service = service
    }

    @discardableResult
    func loadBooks() -> Task<Void, Never> {
        Task {
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
