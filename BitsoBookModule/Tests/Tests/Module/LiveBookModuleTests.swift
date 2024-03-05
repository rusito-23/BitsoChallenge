import SwiftUI
import XCTest
@testable import BitsoBookModule

@MainActor
final class LiveBookModuleTests: XCTestCase {
    private var module: LiveBookModule!

    override func setUp() {
        super.setUp()
        module = LiveBookModule(environment: EnvironmentMock.mock)
    }

    func test_navigate_toPublicDestination() {
        let destination: BookDestination = .bookList
        let coordinator = module.coordinator(for: destination)
        XCTAssert(coordinator is BookListCoordinator)
    }

    func test_navigate_toInternalDestination() {
        let destination: BookInternalDestination = .bookDetails(id: "book_id")
        let coordinator = module.internalCoordinator(for: destination)
        XCTAssert(coordinator is BookDetailsCoordinator)
    }
}
