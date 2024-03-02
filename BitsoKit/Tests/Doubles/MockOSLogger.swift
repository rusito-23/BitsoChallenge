import os
@testable import BitsoKit

final class MockOSLogger: OSLoggerProtocol {
    private(set) var lastLog: (level: OSLogType, message: String)?

    func log(level: OSLogType, message: String) {
        lastLog = (level: level, message: message)
    }
}
