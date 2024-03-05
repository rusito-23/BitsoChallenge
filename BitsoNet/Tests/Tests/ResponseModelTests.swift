import XCTest
@testable import BitsoNet

final class ResponseModelTests: XCTestCase {
    private var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }

    func test_decode_withValidResponseSuccess_shouldSucceed() throws {
        // GIVEN
        let data = try responseData(from: "ResponseSuccess")

        // WHEN
        let response = try decoder.decode(ResponseModel<PayloadMock>.self, from: data)

        // THEN
        guard case .success = response else {
            return XCTFail("Expected response .success but found \(response) instead.")
        }
    }

    func test_decode_withValidResponseFailure_shouldSucceed() throws {
        // GIVEN
        let data = try responseData(from: "ResponseFailure")

        // WHEN
        let response = try decoder.decode(ResponseModel<PayloadMock>.self, from: data)

        // THEN
        guard case let .failure(message, code) = response else {
            return XCTFail("Expected response .failure but found \(response) instead.")
        }
        XCTAssertEqual(message, "Error message")
        XCTAssertEqual(code, 9000)
    }

    func test_decode_withInvalidResponse_shouldFail() throws {
        // GIVEN
        let data = try responseData(from: "ResponseInvalid")

        // WHEN
        let response = try? decoder.decode(ResponseModel<PayloadMock>.self, from: data)

        // THEN
        XCTAssertNil(response)
    }
}

// MARK: - Test Utils

private extension ResponseModelTests {
    /// Load the response data from a JSON file.
    func responseData(from file: String) throws -> Data {
        let url = try XCTUnwrap(Bundle.module.url(forResource: file, withExtension: "json"))
        return try Data(contentsOf: url)
    }
}
