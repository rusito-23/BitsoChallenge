import BitsoUI
import Combine
import XCTest
@testable import BitsoBookModule

@MainActor
final class BookListViewModelTests: XCTestCase {
    private var mockModel: [Book]!
    private var mockService: BookServiceMock!
    private var mockTimerManager: TimerManagerMock!
    private var viewModel: BookListViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() async throws {
        try await super.setUp()
        mockModel = try load(from: "Books")
        mockService = BookServiceMock()
        mockTimerManager = TimerManagerMock()
        viewModel = BookListViewModel(service: mockService, timerManager: mockTimerManager)
        cancellables = Set<AnyCancellable>()
    }

    func test_periodicReload_shouldStartTimer() async throws {
        // GIVEN
        mockService.bookListResult = .success(mockModel)

        // WHEN
        viewModel.startPeriodicReload()

        // THEN
        XCTAssertEqual(mockTimerManager.interval, 30)
        XCTAssertEqual(mockTimerManager.repeats, true)
        XCTAssertNotNil(mockTimerManager.task)
    }

    func test_periodicReload_shouldReloadBooks() async throws {
        // GIVEN
        mockService.bookListResult = .success(mockModel)

        // THEN
        viewModel.$state
            .dropFirst()
            .assert(on: self, next: [
                .loading,
                .loaded(books: [
                    .init(
                        id: "btc_mxn",
                        name: "BTC MXN",
                        maximumValue: "$50000000",
                        minimumValue: "$5",
                        maximumPrice: "$16000000"
                    ),
                    .init(
                        id: "eth_btc",
                        name: "ETH BTC",
                        maximumValue: "$2000.00000000",
                        minimumValue: "$0.00000100",
                        maximumPrice: "$5000.00000000"
                    ),
                ]),
            ])
            .store(in: &cancellables)

        // WHEN
        viewModel.startPeriodicReload()
        await mockTimerManager.trigger()?.value

        waitForExpectations()
    }

    func test_loadBooks_withServiceSuccess_shouldUpdateState() async throws {
        // GIVEN
        mockService.bookListResult = .success(mockModel)

        // THEN
        viewModel.$state
            .dropFirst()
            .assert(on: self, next: [
                .loading,
                .loaded(books: [
                    .init(
                        id: "btc_mxn",
                        name: "BTC MXN",
                        maximumValue: "$50000000",
                        minimumValue: "$5",
                        maximumPrice: "$16000000"
                    ),
                    .init(
                        id: "eth_btc",
                        name: "ETH BTC",
                        maximumValue: "$2000.00000000",
                        minimumValue: "$0.00000100",
                        maximumPrice: "$5000.00000000"
                    ),
                ]),
            ])
            .store(in: &cancellables)

        // WHEN
        let task = viewModel.loadBooks()
        await task.value

        waitForExpectations()
    }

    func test_loadBooks_withEmptyResults_shouldUpdateState() async throws {
        // GIVEN
        mockService.bookListResult = .success([])

        // THEN
        viewModel.$state
            .dropFirst()
            .assert(on: self, next: [
                .loading,
                .failed(notice: NoticeViewModel(
                    icon: .magnifyingGlass,
                    title: "Oops!",
                    message: "We couldn't find anything"
                )),
            ])
            .store(in: &cancellables)

        // WHEN
        let task = viewModel.loadBooks()
        await task.value

        waitForExpectations()
    }

    func test_loadBooks_withServiceError_shouldUpdateState() async throws {
        // GIVEN
        mockService.bookListResult = .failure(.unknown)

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
        let task = viewModel.loadBooks()
        await task.value

        waitForExpectations()
    }
}

// MARK: - Equatable State

extension BookListState: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.failed, .failed):
            return true
        case let (.loaded(lhsModel), .loaded(rhsModel)):
            return lhsModel == rhsModel
        default:
            return false
        }
    }
}

extension BookCardViewModel: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.maximumValue == rhs.maximumValue &&
        lhs.minimumValue == rhs.minimumValue &&
        lhs.maximumPrice == rhs.maximumPrice
    }
}
