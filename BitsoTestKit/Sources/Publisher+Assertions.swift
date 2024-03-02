import Combine
import XCTest

public extension Publisher where Failure == Never, Output: Equatable {
    /// Sets up an assert for only the first value returned by a publisher.
    /// - Parameter value: The expected output of the publisher.
    /// - Parameter testCase: The test case that is asserting the value.
    /// - Parameter file: The source file of the test case. Used by XCTest to point the error in the correct file.
    /// - Parameter line: The line in the source file of the test case. Used by XCTest to point the error in the correct file.
    /// - Note: Important: This util only sets up the expectation, the test case will still need to wait for them.
    func assertEqual(
        to value: Output,
        _ testCase: XCTestCase,
        file: StaticString = #file,
        line: UInt = #line
    ) -> AnyCancellable {
        let expectation = testCase.expectation(description: "")
        return self
            .sink {
                XCTAssertEqual($0, value, file: file, line: line)
                expectation.fulfill()
            }
    }
}
