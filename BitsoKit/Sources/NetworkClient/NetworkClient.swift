import Foundation

/// Describes the methods that need to be implemented as part of a network client.
///
/// A network client is a wrapper around the `URLSession` class to:
/// - allow injection without having to use a stub URL session.
/// - allows handling codable payloads to prevent managing data.
/// - improve the interface by providing an easy-to-use `Result`.
protocol NetworkClient {

    /// Performs a network call using the given API details.
    /// - Parameter endpoint: The ``Endpoint`` for the service call.
    /// - Returns result: A result that indicates whether the call was successful and provides the retrieved payload or error.
    func perform<ResponsePayload: Decodable>(
        _ endpoint: EndpointProvider
    ) async -> Result<ResponsePayload, ServiceError>
}
