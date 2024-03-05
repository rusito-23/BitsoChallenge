import os
@testable import BitsoKit

final class OSLoggerMock: OSLoggerProtocol {
    private(set) var lastLog: (level: OSLogType, message: String)?

    func log(level: OSLogType, message: String) {
        lastLog = (level: level, message: message)
    }
}
