import BitsoUI
import XCTest

final class BorderTests: XCTestCase {
    func test_width_shouldHaveExpectedValues() {
        let values: [Border.Width] = [
            .light,
            .regular,
            .bold,
        ]

        XCTAssertEqual(values.map(\.rawValue), [
            0.5,
            1.0,
            2.0,
        ])
    }

    func test_radius_shouldHaveExpectedValues() {
        let values: [Border.Radius] = [
            .small,
            .medium,
            .large,
        ]

        XCTAssertEqual(values.map(\.rawValue), [
            10.0,
            20.0,
            50.0,
        ])
    }
}
