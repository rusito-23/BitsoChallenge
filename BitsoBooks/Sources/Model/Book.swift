import Foundation

/// Describes the basic information about a book.
/// - Note: Ignores _fees_ object.
struct Book: Decodable {
    /// The order book symbol.
    let book: String

    /// Price chart that provides information about the current and past state of the market.
    let defaultChart: Chart

    /// The minimum amount of major when placing an order.
    let minimumAmount: String

    /// The maximum amount of major when placing an order.
    let maximumAmount: String

    /// The minimum price when placing an order.
    let minimumPrice: String

    /// The maximum price when placing an order.
    let maximumPrice: String

    /// The minimum value amount (amount*price) when placing an order.
    let minimumValue: String

    /// The maximum value amount (amount x price) when placing an order.
    let maximumValue: String

    /// The minimum price difference that must exist at all times
    /// between consecutive bid and offer prices in the order book.
    let tickSize: String
}

// MARK: - Chart

extension Book {
    enum Chart: String, Decodable {
        case depth
        case candle
        case hollow
        case line
        case tradingView
    }
}
