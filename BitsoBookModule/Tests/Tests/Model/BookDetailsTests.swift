import XCTest
@testable import BitsoBookModule

final class BookDetailsTests: XCTestCase {
    private var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
    }

    func test_decode_withValidData() throws {
        let jsonString = """
        {
            "book": "btc_mxn",
            "created_at": "2023-03-09T20:58:23+00:00",
            "high": "472472.82",
            "last": "372110.00",
            "volume": "112.81964756",
            "vwap": "388387.4631589659",
            "low": "10000.00",
            "ask": "372800.00",
            "bid": "372110.00",
            "change_24": "-25580.00"
        }
        """

        let data = Data(jsonString.utf8)
        let model = try decoder.decode(BookDetails.self, from: data)

        XCTAssertEqual(model.name, "btc_mxn")
        XCTAssertEqual(model.high, "472472.82")
        XCTAssertEqual(model.last, "372110.00")
        XCTAssertEqual(model.volume, "112.81964756")
        XCTAssertEqual(model.vwap, "388387.4631589659")
        XCTAssertEqual(model.low, "10000.00")
        XCTAssertEqual(model.ask, "372800.00")
        XCTAssertEqual(model.bid, "372110.00")
        XCTAssertEqual(model.change, "-25580.00")
    }

    func test_decode_withInvalidDate() {
        let jsonString = """
        {
            "book": "btc_mxn",
            "created_at": "2023-03-09 20:58:23",
            "high": "472472.82",
            "last": "372110.00",
            "volume": "112.81964756",
            "vwap": "388387.4631589659",
            "low": "10000.00",
            "ask": "372800.00",
            "bid": "372110.00",
            "change_24": "-25580.00"
        }
        """

        let data = Data(jsonString.utf8)
        let model = try? decoder.decode(BookDetails.self, from: data)
        XCTAssertNil(model)
    }

    func test_decode_withMissingData() {
        let jsonString = """
        {
            "book": "btc_mxn",
            "created_at": "2023-03-09T20:58:23+00:00",
            "high": "472472.82",
            "last": "372110.00",
            "volume": "112.81964756",
            "vwap": "388387.4631589659",
            "low": "10000.00",
            "ask": "372800.00",
            "bid": "372110.00"
        }
        """

        let data = Data(jsonString.utf8)
        let model = try? decoder.decode(BookDetails.self, from: data)
        XCTAssertNil(model)
    }
}
