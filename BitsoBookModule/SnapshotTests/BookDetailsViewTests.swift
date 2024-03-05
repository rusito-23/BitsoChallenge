import BitsoUI
import SnapshotTesting
import XCTest
@testable import BitsoBookModule

@MainActor
final class BookDetailsViewTests: SnapshotTestCase {
    final class ViewModelMock: BookDetailsViewModeling {
        var state: BookDetailsViewState = .loading
        init(state: BookDetailsViewState) { self.state = state }
        func load() -> Task<Void, Never> { Task {} }
    }

    func test_body_loaded() {
        let viewModel = ViewModelMock(state: .loaded(
            title: "BTC MXN",
            sections: [
                .init(items: [
                    (label: "volume", value: "1000"),
                    (label: "high", value: "1000"),
                    (label: "bid", value: "1000"),
                ]),
                .init(items: [
                    (label: "ask", value: "1200"),
                    (label: "bid", value: "1200"),
                ]),
            ]
        ))

        let view = BookDetailsView(viewModel: viewModel)
            .fixedSize(horizontal: true, vertical: true)

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }

    func test_body_failure() {
        let viewModel = ViewModelMock(state: .failed(notice: NoticeViewModel(
            icon: .error,
            title: "Oops!",
            message: "Something went wrong."
        )))

        let view = BookDetailsView(viewModel: viewModel)
            .fixedSize(horizontal: true, vertical: true)

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }
}
