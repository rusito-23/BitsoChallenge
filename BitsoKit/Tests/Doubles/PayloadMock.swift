import Foundation

/// A mock payload that can be encoded and decoded.
/// Contains a unique identifier to allow comparison and a mock value to test encoding failures.
struct PayloadMock: Codable, Equatable {
    let id: UUID
    let value: Double

    init(id: UUID = UUID(), value: Double = 0) {
        self.id = id
        self.value = value
    }
}
