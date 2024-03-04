import Foundation

/// Describes the basic information about a book.
/// - Note: Ignores _fees_ object.
struct Book: Decodable {
    /// The order book symbol.
    let name: String

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

// MARK: Coding Keys

extension Book {
    enum CodingKeys: String, CodingKey {
        case name = "book"
        case defaultChart = "default_chart"
        case minimumAmount = "minimum_amount"
        case maximumAmount = "maximum_amount"
        case minimumPrice = "minimum_price"
        case maximumPrice = "maximum_price"
        case minimumValue = "minimum_value"
        case maximumValue = "maximum_value"
        case tickSize = "tick_size"
    }
}

// MARK: - Chart

extension Book {
    enum Chart: String, Decodable {
        case depth = "depth"
        case candle = "candle"
        case hollow = "hollow"
        case line = "line"
        case tradingView = "tradingview"
    }
}
