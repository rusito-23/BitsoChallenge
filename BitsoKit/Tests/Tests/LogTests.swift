import os
import XCTest
@testable import BitsoKit

final class LogTests: XCTestCase {

    // MARK: Properties

    private var osLogger: OSLoggerMock!
    private var dateProvider: DateProviderMock!
    private var log: Log!
    private var formattedDate: String { dateProvider.now().formatted(.iso8601) }

    // MARK: Set Up

    override func setUp() {
        osLogger = OSLoggerMock()
        dateProvider = DateProviderMock()
        log = Log(logger: osLogger, dateProvider: dateProvider)
    }

    // MARK: Tests

    func test_debug() {
        log.debug("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .debug)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) DEBUG 💬 \
        [LogTests.swift:25:test_debug()] -> test-message
        """)
    }

    func test_info() {
        log.info("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .info)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) INFO ℹ️ \
        [LogTests.swift:35:test_info()] -> test-message
        """)
    }

    func test_warning() {
        log.warning("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .info)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) WARNING ⚠️ \
        [LogTests.swift:45:test_warning()] -> test-message
        """)
    }

    func test_error() {
        log.error("test-message")

        XCTAssertEqual(osLogger.lastLog?.level, .error)
        XCTAssertEqual(osLogger.lastLog?.message, """
        \(formattedDate) ERROR ‼️ \
        [LogTests.swift:55:test_error()] -> test-message
        """)
    }
}
