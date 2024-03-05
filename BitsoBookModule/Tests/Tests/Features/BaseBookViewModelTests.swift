import XCTest
@testable import BitsoBookModule

final class BaseBookViewModelTests: XCTestCase {
    private var locale: Locale!
    private var viewModel: BaseBookViewModel!

    override func setUp() {
        super.setUp()
        locale = Locale(identifier: "en_US")
        viewModel = BaseBookViewModel()
    }

    func test_displayName_withLowercasedName_withUnderscores() {
        let displayName = viewModel.displayName(from: "btc_ars")
        XCTAssertEqual(displayName, "BTC ARS")
    }

    func test_displayName_withUnderscores() {
        let displayName = viewModel.displayName(from: "BTC_ARS")
        XCTAssertEqual(displayName, "BTC ARS")
    }

    func test_displayName_withLowercasedName_withoutUnderscores() {
        let displayName = viewModel.displayName(from: "btc ars")
        XCTAssertEqual(displayName, "BTC ARS")
    }

    func test_currencyFormat() {
        let currencyValue = viewModel.currencyFormat(value: "3000.0000", locale: locale)
        XCTAssertEqual(currencyValue, "$3000.0000")
    }

    func test_currencyFormat_withNegativeValue() {
        let currencyValue = viewModel.currencyFormat(value: "-3000.0000", locale: locale)
        XCTAssertEqual(currencyValue, "-$3000.0000")
    }
}
