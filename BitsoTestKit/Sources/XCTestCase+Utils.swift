import XCTest

public extension XCTestCase {
    /// Wait for expectations with a default timeout.
    func waitForExpectations() {
        waitForExpectations(timeout: 10)
    }
}
