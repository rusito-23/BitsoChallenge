import os
import XCTest
@testable import BitsoKit

final class LogTests: XCTestCase {

    // MARK: Properties

    private var osLogger: MockOSLogger!
    private var dateProvider: MockDateProvider!
    private var log: Log!
    private var formattedDate: String { dateProvider.now().formatted(.iso8601) }

    // MARK: Set Up

    override func setUp() {
        osLogger = MockOSLogger()
        dateProvider = MockDateProvider()
        log = Log(logger: osLogger, dateProvider: dateProvider)
    }

    // MARK: Tests

    func testDebug() {
        log.debug("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .debug)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) DEBUG 💬 \
        [LogTests.swift:25:testDebug()] -> test-message
        """)
    }

    func testInfo() {
        log.info("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .info)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) INFO ℹ️ \
        [LogTests.swift:35:testInfo()] -> test-message
        """)
    }

    func testWarning() {
        log.warning("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .info)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) WARNING ⚠️ \
        [LogTests.swift:45:testWarning()] -> test-message
        """)
    }

    func testError() {
        log.error("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .error)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) ERROR ‼️ \
        [LogTests.swift:55:testError()] -> test-message
        """)
    }

    func testNetwork() throws {
        let url = try XCTUnwrap(URL(string: "https://site.com/path"))

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let response = try XCTUnwrap(
            HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["key": "value"]
            )
        )

        log.network(request, response)

        XCTAssertEqual(osLogger.lastLog?.level, .debug)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) DEBUG 💬 \
        [LogTests.swift:79:testNetwork()] -> \

        Request GET https://site.com/path:
            Body Bytes: 0
            Headers: [:]
        Response:
            Status Code: 200
            Headers: [AnyHashable("key"): value]
        """)
    }
}
