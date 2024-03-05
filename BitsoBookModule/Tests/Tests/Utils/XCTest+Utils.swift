import Foundation
import XCTest

extension XCTestCase {
    /// Generic util to load decodable models from a JSON file.
    func load<Model: Decodable>(from file: String) throws -> Model {
        let url = try XCTUnwrap(Bundle.module.url(forResource: file, withExtension: "json"))
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Model.self, from: data)
    }

    /// Set a common expectation timeout.
    func waitForExpectations() {
        waitForExpectations(timeout: 10.0)
    }
}
