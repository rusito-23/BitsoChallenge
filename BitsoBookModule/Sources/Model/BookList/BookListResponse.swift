import Foundation

/// Describes the expected response for books list.
struct BookListResponse: Decodable {
    let payload: [Book]
}
