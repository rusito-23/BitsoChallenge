import BitsoNet
import Foundation

/// The live implementation of ``BookService``.
final class LiveBookService: BookService {

    // MARK: Private Properties

    /// The network client to fetch book data. Defaults to a new `LiveNetworkClient`.
    private let client: NetworkClient

    // MARK: Initializer

    /// Create a new live book service.
    /// - Parameter client: The network client to fetch book data. Defaults to a new `LiveNetworkClient`.
    init(
        domain: DomainProvider,
        client: NetworkClient?  = nil
    ) {
        self.client = client ?? LiveNetworkClient(domain: domain)
    }

    // MARK: Service Conformance

    func fetchAll() async -> Result<[Book], BookServiceError> {
        let endpoint = BookEndpoint.booksList
        let result: Result<BookListResponse, NetworkError> = await client.perform(endpoint)

        switch result {
        case let .success(response):
            return .success(response.payload)
        case .failure:
            return .failure(.network)
        }
    }

    func fetchDetails(with bookID: String) -> Result<Book, BookServiceError> {
        .failure(.network)
    }
}

// MARK: - Endpoint

private extension LiveBookService {
    enum BookEndpoint: Endpoint {
        case booksList
        case bookDetails(id: String)

        /// The endpoint path.
        var path: String {
            switch self {
            case .booksList: return "available_books"
            case .bookDetails: return "ticker"
            }
        }

        /// The parameters for the endpoint request.
        var parameters: [URLQueryItem] {
            switch self {
            case let .bookDetails(id: id):
                return  [.init(name: "book", value: id)]
            default:
                return []
            }
        }

        /// All endpoints in this service will use the `GET` method.
        var method: HTTP.Method {
            .get
        }

        /// None of the endpoints in this service will use additional headers.
        var additionalHeaders: [Header] {
            []
        }

        /// None of the endpoints in this service will contain a request payload.
        var requestPayload: Encodable? {
            nil
        }
    }
}
