import BitsoNet
import Foundation

/// The live implementation of the books service.
final class LiveBooksService: BooksService {

    // MARK: Private Properties

    /// The network client to fetch book data. Defaults to a new `LiveNetworkClient`.
    private let client: NetworkClient

    // MARK: Initializer

    /// Create a new live book service.
    /// - Parameter client: The network client to fetch book data. Defaults to a new `LiveNetworkClient`.
    init(client: NetworkClient = LiveNetworkClient()) {
        self.client = client
    }

    // MARK: Service Conformance

    func fetchAll() async -> Result<[Book], BooksServiceError> {
        .failure(.generic)
    }

    func fetchDetails(with bookID: String) -> Result<Book, BooksServiceError> {
        .failure(.generic)
    }
}

// MARK: - Endpoint

private extension LiveBooksService {
    struct BookDomain: Domain {
        let scheme: String = "https"
        let host: String = "sandbox.bitso.com"
        let path: String? = "api/v3"
    }

    enum BookEndpoint: Endpoint {
        case booksList
        case bookDetails(id: String)

        var domain: Domain {
            BookDomain()
        }

        var method: HTTP.Method {
            .get
        }

        var path: String {
            switch self {
            case .booksList: return ""
            case .bookDetails: return ""
            }
        }

        var parameters: [URLQueryItem] {
            switch self {
            case let .bookDetails(id: id):
                return  [.init(name: "id", value: id)]
            default:
                return []
            }
        }

        var additionalHeaders: [Header] {
            []
        }

        var requestPayload: Encodable? {
            nil
        }
    }
}
