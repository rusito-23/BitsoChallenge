import SnapshotTesting
import XCTest
@testable import BitsoBookModule

final class BookCardViewTests: SnapshotTestCase {
    func test_body() {
        let viewModel = BookCardViewModel(
            id: "book_id",
            name: "Book Name",
            maximumValue: "$ 150",
            minimumValue: "$ 100",
            maximumPrice: "$ 200"
        )

        let view = BookCardView(viewModel: viewModel)
            .fixedSize(horizontal: true, vertical: true)

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }
}
