import BitsoKit
import BitsoUI
import Foundation

// MARK: - State

enum BookDetailsViewState {
    case loading
    case loaded(title: String, sections: [Section])
    case failed(notice: NoticeViewModel)

    struct Section: Identifiable {
        let id = UUID()
        let items: [(label: String, value: String)]
    }
}

// MARK: - Protocol

@MainActor
protocol BookDetailsViewModeling: ObservableObject {
    /// The current state of the view.
    var state: BookDetailsViewState { get }

    /// Loads the details for the book.
    /// - Returns: The discardable task that will perform the load.
    @discardableResult
    func load() -> Task<Void, Never>
}

// MARK: - View Model

@MainActor
final class BookDetailsViewModel: BaseBookViewModel, BookDetailsViewModeling {
    @Published private(set) var state: BookDetailsViewState = .loading

    private let bookID: String
    private let service: BookService

    init(bookID: String, service: BookService) {
        self.bookID = bookID
        self.service = service
    }

    @discardableResult
    func load() -> Task<Void, Never> {
        Task {
            state = .loading
            let result = await service.fetchDetails(with: bookID)
            switch result {

            case let .success(details):
                state = .loaded(
                    title: displayName(from: details.name),
                    sections: [
                        .init(items: [
                            (
                                label: Content.volume.localized,
                                value: currencyFormat(value: details.volume)
                            ),
                            (
                                label: Content.high.localized,
                                value: currencyFormat(value: details.high)
                            ),
                            (
                                label: Content.change.localized,
                                value: currencyFormat(value: details.change)
                            ),
                        ]),
                        .init(items: [
                            (
                                label: Content.ask.localized,
                                value: currencyFormat(value: details.ask)
                            ),
                            (
                                label: Content.bid.localized,
                                value: currencyFormat(value: details.bid)
                            ),
                        ]),
                    ]
                )

            case .failure:
                let notice = NoticeViewModel(
                    icon: .error,
                    title: Content.noticeTitle.localized,
                    message: Content.generalErrorMessage.localized
                )
                state = .failed(notice: notice)
            }
        }
    }
}

// MARK: - Localizable Content

private extension BookDetailsViewModel {
    enum Content: String, LocalizableContent {
        case noticeTitle = "OOPS"
        case generalErrorMessage = "GENERAL_ERROR_MESSAGE"

        case volume = "VOLUME_LABEL"
        case high = "HIGH_LABEL"
        case change = "CHANGE_LABEL"
        case ask = "ASK_LABEL"
        case bid = "BID_LABEL"

        var localized: String {
            localize(bundle: .module)
        }
    }
}
