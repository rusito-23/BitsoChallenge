import Combine
import XCTest

extension Publisher where Output: Equatable, Failure == Never {
    /// Assert that the published output takes a particular value up next.
    func assert(
        on testCase: XCTestCase,
        equalsTo expected: Output,
        file: StaticString = #file,
        line: UInt = #line
    ) -> AnyCancellable {
        let expectation = testCase.expectation(description: "Expect Next Published Value")
        return sink { value in
            XCTAssertEqual(value, expected, file: file, line: line)
            expectation.fulfill()
        }
    }

    /// Assert that the published output takes a series of values.
    /// - Precondition: the `expectedValues` array can't be empty.
    func assert(
        on testCase: XCTestCase,
        next expectedValues: [Output],
        file: StaticString = #file,
        line: UInt = #line
    ) -> AnyCancellable {
        var expectedValues = expectedValues
        let expectation = testCase.expectation(description: "Expected Published Values")
        return sink { value in
            XCTAssertEqual(value, expectedValues.removeFirst(), file: file, line: line)
            if expectedValues.isEmpty { expectation.fulfill() }
        }
    }
}
