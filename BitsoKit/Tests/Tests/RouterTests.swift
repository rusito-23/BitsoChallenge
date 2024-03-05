import BitsoKit
import XCTest

final class RouterTests: XCTestCase {
    private var router: Router!

    override func setUp() {
        super.setUp()
        router = Router()
    }

    func test_navigation_shouldUpdatePath() {
        XCTAssertEqual(router.path.count, 0)

        router.navigate(to: DestinationMock.first)
        XCTAssertEqual(router.path.count, 1)

        router.pop()
        XCTAssertEqual(router.path.count, 0)

        router.navigate(to: DestinationMock.first)
        router.navigate(to: DestinationMock.second)
        XCTAssertEqual(router.path.count, 2)

        router.popToRoot()
        XCTAssertEqual(router.path.count, 0)
    }
}
