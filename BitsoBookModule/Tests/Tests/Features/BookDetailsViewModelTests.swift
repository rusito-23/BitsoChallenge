import BitsoUI
import Combine
import XCTest
@testable import BitsoBookModule

@MainActor
final class BookDetailsViewModelTests: XCTestCase {
    private var mockModel: BookDetails!
    private var mockService: BookServiceMock!
    private var viewModel: BookDetailsViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() async throws {
        try await super.setUp()
        mockModel = try load(from: "BookDetails")
        mockService = BookServiceMock()
        viewModel = BookDetailsViewModel(bookID: "book_id", service: mockService)
        cancellables = Set<AnyCancellable>()
    }

    func test_load_withServiceSuccess_shouldUpdateState() async throws {
        // GIVEN
        mockService.bookDetailsResult = .success(mockModel)

        // THEN
        viewModel.$state
            .dropFirst()
            .assert(on: self, next: [
                .loading,
                .loaded(
                    title: "BTC MXN",
                    sections: [
                        .init(items: [
                            (label: "Volume", value: "$112.81964756"),
                            (label: "High", value: "$472472.82"),
                            (label: "Change", value: "-$25580.00"),
                        ]),
                        .init(items: [
                            (label: "Ask", value: "$372800.00"),
                            (label: "Bid", value: "$372110.00"),
                        ]),
                    ]
                ),
            ])
            .store(in: &cancellables)

        // WHEN
        let task = viewModel.load()
        await task.value

        waitForExpectations()
    }

    func test_load_withServiceFailure_shouldUpdateState() async throws {
        // GIVEN
        mockService.bookDetailsResult = .failure(.unknown)

        // THEN
        viewModel.$state
            .dropFirst()
            .assert(on: self, next: [
                .loading,
                .failed(notice: NoticeViewModel(
                    icon: .error,
                    title: "Oops!",
                    message: "Something went wrong."
                )),
            ])
            .store(in: &cancellables)

        // WHEN
        let task = viewModel.load()
        await task.value
        waitForExpectations(timeout: 10.0)
    }
}

// MARK: - Equatable State

extension BookDetailsViewState: Equatable {
    public static func == (lhs: BookDetailsViewState, rhs: BookDetailsViewState) -> Bool {
        switch (lhs, rhs) {
        case let (.loaded(lhsTitle, lhsSections), .loaded(rhsTitle, rhsSections)):
            return lhsTitle == rhsTitle && lhsSections == rhsSections
        case (.loading, .loading):
            return true
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}

extension BookDetailsViewState.Section: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.items.map(\.label) == rhs.items.map(\.label) &&
        lhs.items.map(\.value) == rhs.items.map(\.value)
    }
}
