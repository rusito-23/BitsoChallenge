import Foundation

/// Describes the basic information about a book.
/// - Note: Ignores _rolling_average_change_ object.
struct BookDetails: Decodable {
    /// The lowest sell order.
    let ask: String?

    /// The highest buy order.
    let bid: String

    /// The order book symbol.
    let name: String

    /// The price variation during the last 24 hours.
    let change: String

    /// The date and time when the service generated the ticker.
    let createdAt: Date

    /// The last-24-hour price high.
    let high: String

    /// The last-traded price.
    let last: String

    /// The last-24-hour price low.
    let low: String

    /// The last-24-hour volume.
    let volume: String

    /// The last-24-hour-volume-weighted average price.
    let vwap: String
}

// MARK: - Coding Keys

private extension BookDetails {
    enum CodingKeys: String, CodingKey {
        case ask
        case bid
        case name = "book"
        case change = "change_24"
        case createdAt = "created_at"
        case high
        case last
        case low
        case volume
        case vwap
    }
}
