import BitsoUI
import SnapshotTesting
import XCTest

final class NoticeViewTests: SnapshotTestCase {
    func test_notice_forEmptyResult() {
        let viewModel = NoticeViewModel(
            icon: .magnifyingGlass,
            title: "Oops!",
            message: "We couldn't find any results"
        )

        let view = NoticeView(viewModel: viewModel)
            .fixedSize(horizontal: true, vertical: true)

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }

    func test_notice_forError() {
        let viewModel = NoticeViewModel(
            icon: .error,
            title: "Oops!",
            message: "We couldn't find any results"
        )

        let view = NoticeView(viewModel: viewModel)
            .fixedSize(horizontal: true, vertical: true)

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }
}
