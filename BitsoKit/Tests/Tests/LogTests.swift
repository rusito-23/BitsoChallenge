import os
import XCTest
@testable import BitsoKit

final class LogTests: XCTestCase {
    private var osLogger: OSLoggerMock!
    private var log: Log!

    override func setUp() {
        osLogger = OSLoggerMock()
        log = Log(logger: osLogger)
    }

    func test_debug() {
        log.debug("test-message", line: 15)

        XCTAssertEqual(osLogger.lastLog?.level, .debug)
        XCTAssertEqual(osLogger.lastLog?.message, """
        DEBUG 💬 \
        [LogTests.swift:15:test_debug()] -> test-message
        """)
    }

    func test_info() {
        log.info("test-message", line: 25)

        XCTAssertEqual(osLogger.lastLog?.level, .info)
        XCTAssertEqual(osLogger.lastLog?.message, """
        INFO ℹ️ \
        [LogTests.swift:25:test_info()] -> test-message
        """)
    }

    func test_warning() {
        log.warning("test-message", line: 35)

        XCTAssertEqual(osLogger.lastLog?.level, .info)
        XCTAssertEqual(osLogger.lastLog?.message, """
        WARNING ⚠️ \
        [LogTests.swift:35:test_warning()] -> test-message
        """)
    }

    func test_error() {
        log.error("test-message", line: 45)

        XCTAssertEqual(osLogger.lastLog?.level, .error)
        XCTAssertEqual(osLogger.lastLog?.message, """
        ERROR ‼️ \
        [LogTests.swift:45:test_error()] -> test-message
        """)
    }
}
