import BitsoUI
import XCTest

final class SpacingTests: XCTestCase {
    func test_spacing_shouldHaveExpectedValues() {
        var expectedValues: [CGFloat] = [
            46.0,
            16.0,
            8.0,
        ]

        for spacing in Spacing.allCases {
            guard let expectedValue = expectedValues.popLast() else {
                return XCTFail("Unexpected case not covered: \(spacing)")
            }

            XCTAssertEqual(spacing.rawValue, expectedValue, "Width.\(spacing) failed.")
        }
    }
}
