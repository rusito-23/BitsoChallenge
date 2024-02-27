import BitsoUI
import XCTest

final class BorderTests: XCTestCase {
    func test_width_shouldHaveExpectedValues() {
        var expectedValues: [CGFloat] = [
            2.0,
            1.0,
            0.5,
        ]

        for width in Border.Width.allCases {
            guard let expectedValue = expectedValues.popLast() else {
                return XCTFail("Unexpected case not covered: \(width)")
            }

            XCTAssertEqual(width.rawValue, expectedValue, "Width.\(width) failed.")
        }
    }

    func test_radius_shouldHaveExpectedValues() {
        var expectedValues: [CGFloat] = [
            50.0,
            20.0,
            10.0,
        ]

        for radius in Border.Radius.allCases {
            guard let expectedValue = expectedValues.popLast() else {
                return XCTFail("Unexpected case not covered: \(radius)")
            }

            XCTAssertEqual(radius.rawValue, expectedValue, "Radius.\(radius) failed.")
        }
    }
}
