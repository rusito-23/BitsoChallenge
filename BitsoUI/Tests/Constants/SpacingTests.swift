import BitsoUI
import XCTest

final class SpacingTests: XCTestCase {
    func test_spacing_shouldHaveExpectedValues() {
        let values: [Spacing] = [
            .small,
            .medium,
            .large,
        ]

        XCTAssertEqual(values.map(\.rawValue), [
            8.0,
            16.0,
            46.0,
        ])
    }
}
