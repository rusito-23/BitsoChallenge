import XCTest
@testable import BitsoBookModule

@MainActor
final class BookListCoordinatorTest: XCTestCase {
    private var coordinator: BookListCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = BookListCoordinator(environment: EnvironmentMock.mock)
    }

    func test_coordinator_forDestination() {
        let coordinator = coordinator.coordinator(for: .bookDetails(id: "book_id"))
        XCTAssert(coordinator is BookDetailsCoordinator)
    }
}
