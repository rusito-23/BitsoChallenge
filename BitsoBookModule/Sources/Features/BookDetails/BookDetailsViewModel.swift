import BitsoKit
import BitsoUI
import Foundation

// MARK: - State

enum BookDetailsViewState {
    case loading
    case loaded(sections: [Section])
    case failed(notice: NoticeViewModel)

    struct Section: Identifiable {
        let id = UUID()
        let items: [(label: String, value: String)]
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
    @Published private(set) var title: String?
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
            let result = await service.fetchDetails(with: bookID)
            switch result {

            case let .success(details):
                title = details.name
                state = .loaded(sections: [
                    .init(items: [
                        (label: Content.volume.localized, value: details.volume),
                        (label: Content.high.localized, value: details.high),
                        (label: Content.bid.localized, value: details.bid),
                    ]),
                    .init(items: [
                        (label: Content.ask.localized, value: details.ask),
                        (label: Content.bid.localized, value: details.bid),
                    ]),
                ])

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

private extension LiveBookDetailsViewModel {
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
