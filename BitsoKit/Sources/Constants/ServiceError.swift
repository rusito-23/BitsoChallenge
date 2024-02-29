import Foundation

/// Describes the different kinds of errors that can be thrown while performing a network call.
public enum ServiceError: Error {
    /// When the request, constructed from the client side, is malformed.
    case invalidRequest

    /// When the service returned an invalid response that can't be processed.
    case invalidResponse

    /// When the service determines there has been an internal error.
    case serviceError(code: Int)

    /// When the root cause of the failure can't be determined.
    case unknown
}
