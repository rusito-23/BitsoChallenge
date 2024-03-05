import Foundation

/// Holds constants to interact with HTTP APIs.
public struct HTTP {}

// MARK: - Method

public extension HTTP {
    /// Describes the available methods to perform requests over HTTP.
    enum Method: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"

        /// Determines whether the method supports a body payload.
        /// At the moment, the only method we're not going to support payloads for is `GET`.
        var supportsPayload: Bool {
            switch self {
            case .get: return false
            default: return true
            }
        }
    }
}

// MARK: - Status

extension HTTP {
    /// Describes the different statuses that a response can have.
    /// Internal use only intended.
    enum Status {
        case info
        case success
        case redirect
        case client
        case server
        case unknown

        /// Determine the status based on the status code.
        /// - Parameter statusCode: The Integer status code determined by the response.
        init(_ statusCode: Int) {
            switch statusCode {
            case 100...199: self = .info
            case 200...299: self = .success
            case 300...399: self = .redirect
            case 400...499: self = .client
            case 500...599: self = .server
            default: self = .unknown
            }
        }
    }
}

// MARK: - Headers

extension HTTP {
    /// Determines the headers that can be used by default in all network calls.
    struct Headers {
        /// The header that dictates the content type.
        enum ContentType: String, Header {
            case json = "application/json"

            var key: String {
                "Content-Type"
            }
        }
    }
}
