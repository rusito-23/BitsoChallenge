import BitsoKit
import XCTest

final class LocalizationTests: XCTestCase {
    func test_localize_shouldUseGivenModule() {
        let content: LocalizableContentMock = .content
        let localized = content.localize(bundle: .module)
        XCTAssertEqual(localized, "Mock Localized String")
    }

    func test_localize_withFormat_shouldUseGivenModule() {
        let content: LocalizableContentMock = .contentWithFormat
        let localized = content.localize(bundle: .module, "Test")
        XCTAssertEqual(localized, "Mock Localized String With Format Test")
    }
}
