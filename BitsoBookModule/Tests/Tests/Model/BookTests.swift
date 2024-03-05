import XCTest
@testable import BitsoBookModule

final class BookTests: XCTestCase {
    private var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }

    func test_decode_withValidData() throws {
        let jsonString = """
          {
            "book":"eth_btc",
            "default_chart":"candle",
            "minimum_price":"0.00000100",
            "maximum_price":"5000.00000000",
            "minimum_value":"0.00000100",
            "maximum_value":"2000.00000000",
            "maximum_amount":"1000.00000000",
            "minimum_amount":"0.00000100",
            "tick_size":"0.00000001"
        }
        """

        let data = Data(jsonString.utf8)
        let book = try decoder.decode(Book.self, from: data)

        XCTAssertEqual(book.name, "eth_btc")
        XCTAssertEqual(book.defaultChart, .candle)
        XCTAssertEqual(book.minimumPrice, "0.00000100")
        XCTAssertEqual(book.maximumPrice, "5000.00000000")
        XCTAssertEqual(book.minimumValue, "0.00000100")
        XCTAssertEqual(book.maximumValue, "2000.00000000")
        XCTAssertEqual(book.maximumAmount, "1000.00000000")
        XCTAssertEqual(book.minimumAmount, "0.00000100")
        XCTAssertEqual(book.tickSize, "0.00000001")
    }

    func test_decode_withInvalidChart() throws {
        let jsonString = """
          {
            "book":"eth_btc",
            "default_chart":"invalid",
            "minimum_price":"0.00000100",
            "maximum_price":"5000.00000000",
            "minimum_value":"0.00000100",
            "maximum_value":"2000.00000000",
            "maximum_amount":"1000.00000000",
            "minimum_amount":"0.00000100",
            "tick_size":"0.00000001"
        }
        """

        let data = Data(jsonString.utf8)
        let book = try? decoder.decode(Book.self, from: data)
        XCTAssertNil(book)
    }

    func test_decode_withMissingData() throws {
        let jsonString = """
          {
            "book":"eth_btc",
            "default_chart":"candle",
            "minimum_price":"0.00000100",
            "maximum_price":"5000.00000000",
            "minimum_value":"0.00000100",
            "maximum_value":"2000.00000000",
            "maximum_amount":"1000.00000000",
            "minimum_amount":"0.00000100"
        }
        """

        let data = Data(jsonString.utf8)
        let book = try? decoder.decode(Book.self, from: data)
        XCTAssertNil(book)
    }
}
