import BitsoUI
import SnapshotTesting
import XCTest
@testable import BitsoBookModule

@MainActor
final class BookListViewTests: SnapshotTestCase {
    final class ViewModelMock: BookListViewModeling {
        var title: String = "All Books"
        var state: BookListState
        init(state: BookListState) { self.state = state }
        func startPeriodicReload() {}
        func loadBooks() -> Task<Void, Never> { Task {} }
    }

    func test_body_failure() {
        let viewModel = ViewModelMock(state: .failed(notice: NoticeViewModel(
            icon: .error,
            title: "Oops!",
            message: "Something went wrong."
        )))

        let view = BookListView(viewModel: viewModel)
            .fixedSize(horizontal: true, vertical: true)

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }
}
