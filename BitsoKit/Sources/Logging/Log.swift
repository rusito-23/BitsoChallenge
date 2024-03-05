import os
import Foundation

/// A  public global property to access the logger.
public let log = Log()

/// A general purpose logger that wraps around the `os.Logger` to:
/// - prefix all log messages with general purpose information: date, file, line, column, level.
/// - add specific use-case logs (network).
/// - prevent verbose logging for non-DEBUG builds.
public struct Log {
    private let logger: OSLoggerProtocol
    private let dateProvider: DateProvider

    public init() {
        self.logger = Logger()
        self.dateProvider = LiveDateProvider()
    }

    init(logger: OSLoggerProtocol, dateProvider: DateProvider) {
        self.logger = logger
        self.dateProvider = dateProvider
    }
}

// MARK: - Log Methods

extension Log {
    public func debug(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        log(
            .debug,
            object,
            file: file,
            line: line,
            function: function
        )
    }

    public func info(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        log(
            .info,
            object,
            file: file,
            line: line,
            function: function
        )
    }

    public func warning(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        log(
            .warning,
            object,
            file: file,
            line: line,
            function: function
        )
    }

    public func error(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function
    ) {
        log(
            .error,
            object,
            file: file,
            line: line,
            function: function
        )
    }
}

// MARK: - Level

private extension Log {
    enum Level: String {
        case debug = "DEBUG 💬"
        case info = "INFO ℹ️"
        case warning = "WARNING ⚠️"
        case error = "ERROR ‼️"

        var osLevel: os.OSLogType {
            switch self {
            case .debug: return .debug
            case .info: return .info
            case .warning: return .info
            case .error: return .error
            }
        }
    }
}

// MARK: - Log Utils

private extension Log {
    func log(
        _ level: Level,
        _ object: Any,
        file: String,
        line: Int,
        function: String
    ) {
        let message = """
        \(dateProvider.now().formatted(.iso8601)) \(level.rawValue) \
        [\(filename(file)):\(line):\(function)] -> \(object)
        """
        logger.log(level: level.osLevel, message: message)
    }

    func filename(_ file: String) -> String {
        file.components(separatedBy: "/").last ?? ""
    }
}

// MARK: - OSLog Protocol

protocol OSLoggerProtocol {
    func log(level: OSLogType, message: String)
}

extension Logger: OSLoggerProtocol {
    func log(level: OSLogType, message: String) {
        log(level: level, "\(message)")
    }
}
