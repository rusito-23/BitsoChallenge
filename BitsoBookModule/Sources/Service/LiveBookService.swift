import BitsoNet
import Foundation

/// The live implementation of  the ``BookService`` protocol, using the network client to retrieve the required data.
final class LiveBookService {
    private let client: NetworkClient

    /// Create a new live book service.
    /// - Parameter client: The network client that will be used to perform the network calls.
    init(client: any NetworkClient) {
        self.client = client
    }

    /// Create a new live book service.
    /// - Parameter environment: The component that provides the environment with which the service needs to communicate.
    convenience init(environment: APIEnvironment) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let client = LiveNetworkClient(environment: environment, decoder: decoder)
        self.init(client: client)
    }
}

// MARK: - Service Conformance

extension LiveBookService: BookService {
    func fetchAll() async -> Result<[Book], BookServiceError> {
        let endpoint = Endpoint.booksList
        let result: Result<[Book], NetworkError> = await client.perform(endpoint)

        switch result {
        case let .success(books):
            return .success(books)
        case .failure:
            return .failure(.network)
        }
    }

    func fetchDetails(with bookID: String) async -> Result<BookDetails, BookServiceError> {
        let endpoint = Endpoint.bookDetails(id: bookID)
        let result: Result<BookDetails, NetworkError> = await client.perform(endpoint)

        switch result {
        case let .success(bookDetails):
            return .success(bookDetails)
        case .failure:
            return .failure(.network)
        }
    }
}

// MARK: - Endpoint

private extension LiveBookService {
    enum Endpoint: BitsoNet.Endpoint {
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
