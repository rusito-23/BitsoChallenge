import BitsoKit
import Foundation

struct DateProviderMock: DateProvider {
    let mockNow: Date

    init(mockNow: Date = Date(timeIntervalSince1970: 2300)) {
        self.mockNow = mockNow
    }

    func now() -> Date {
        mockNow
    }
}
