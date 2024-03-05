import XCTest
@testable import BitsoNet

final class LiveNetworkClientTests: XCTestCase {
    private var encoder: JSONEncoder!
    private var decoder: JSONDecoder!
    private var client: LiveNetworkClient!
    private var mockRequestPayload: PayloadMock!
    private var mockResponseData: Data!
    private let environment = EnvironmentMock.valid
    private let endpoint = EndpointMock(method: .post)

    override func setUp() async throws {
        try await super.setUp()

        encoder = JSONEncoder()
        decoder = JSONDecoder()
        mockRequestPayload = PayloadMock()
        mockResponseData = try responseData(from: "ResponseSuccess")

        client = LiveNetworkClient(
            environment: environment,
            urlSession: .mocked,
            encoder: encoder,
            decoder: decoder
        )
    }

    override func tearDown() {
        URLProtocolMock.clear()
        super.tearDown()
    }

    func test_perform_withValidPayload_shouldSucceed() async throws {
        // GIVEN
        URLProtocolMock.add(.data(mockResponseData), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        let expectedPayload = PayloadMock(
            id: try XCTUnwrap(UUID(uuidString: "31e05614-58cf-4ed7-b82c-e4b233a6317b")),
            value: 23
        )
        XCTAssertEqual(result, .success(expectedPayload))
    }

    func test_perform_withValidUnsuccessfulPayload_shouldFail() async throws {
        // GIVEN
        let data = try responseData(from: "ResponseFailure")
        URLProtocolMock.add(.data(data), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.serviceError(code: 9000)))
    }

    func test_perform_withInvalidResponseData_shouldReturnFailure() async throws {
        // GIVEN
        let data = try responseData(from: "ResponseInvalid")
        URLProtocolMock.add(.data(data), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.invalidResponse))
    }

    func test_perform_withInvalidURL_shouldReturnFailure() async {
        // GIVEN
        client = LiveNetworkClient(
            environment: EnvironmentMock.invalid,
            urlSession: .mocked,
            encoder: encoder,
            decoder: decoder
        )

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.invalidRequest))
    }

    func test_perform_withURLSessionFailure_shouldReturnFailure() async {
        // GIVEN
        URLProtocolMock.add(.error(NetworkError.unknown), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.unknown))
    }

    func test_perform_withClientError_shouldReturnFailure() async {
        // GIVEN
        URLProtocolMock.add(.response(statusCode: 400), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.invalidRequest))
    }

    func test_perform_withServerError_shouldReturnFailure() async {
        // GIVEN
        URLProtocolMock.add(.response(statusCode: 500), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.serviceError(code: 500)))
    }

    func test_perform_withInfoCode_shouldReturnFailure() async {
        // GIVEN
        URLProtocolMock.add(.response(statusCode: 100), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.unknown))
    }

    func test_perform_withRedirectCode_shouldReturnFailure() async {
        // GIVEN
        URLProtocolMock.add(.response(statusCode: 300), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.unknown))
    }

    func test_perform_withUnknownCode_shouldReturnFailure() async {
        // GIVEN
        URLProtocolMock.add(.response(statusCode: 600), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.unknown))
    }

    func test_perform_withInvalidResponse_shouldReturnFailure() async {
        // GIVEN
        URLProtocolMock.add(.response(statusCode: 200), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.invalidResponse))
    }

    func test_perform_withAdditionalGenericHeader_shouldBeConsidered() async throws {
        // GIVEN
        let headerMocks = [HeaderMock.generic]
        let endpoint = EndpointMock(additionalHeaders: headerMocks)
        URLProtocolMock.add(.data(mockResponseData), for: url(from: environment, endpoint))

        // WHEN
        await perform(endpoint)

        // THEN
        let request = try XCTUnwrap(URLProtocolMock.lastProcessedRequest)
        XCTAssertEqual(request.allHTTPHeaderFields, [
            "Content-Type": "application/json",
            "KeyMock": "ValueMock",
        ])
    }

    func test_perform_withAdditionalContentTypeHeader_shouldBePrioritized() async throws {
        // GIVEN
        let headerMocks = [HeaderMock.contentTypeXML, HeaderMock.generic]
        let endpoint = EndpointMock(additionalHeaders: headerMocks)
        URLProtocolMock.add(.data(mockResponseData), for: url(from: environment, endpoint))

        // WHEN
        await perform(endpoint)

        // THEN
        let request = try XCTUnwrap(URLProtocolMock.lastProcessedRequest)
        XCTAssertEqual(request.allHTTPHeaderFields, [
            "Content-Type": "application/xml",
            "KeyMock": "ValueMock",
        ])
    }

    func test_perform_withRequestPayload_shouldBeEncoded() async throws {
        // GIVEN
        let endpoint = EndpointMock(method: .post, requestPayload: mockRequestPayload)
        URLProtocolMock.add(.data(mockResponseData), for: url(from: environment, endpoint))

        // WHEN
        await perform(endpoint)

        // THEN
        let request = try XCTUnwrap(URLProtocolMock.lastProcessedRequest)
        let data = try XCTUnwrap(request.bodyStreamData)
        XCTAssertEqual(mockRequestPayload, try decoder.decode(PayloadMock.self, from: data))
    }

    func test_perform_withRequestPayload_whenMethodDoesNotSupportPayload() async throws {
        // GIVEN
        let endpoint = EndpointMock(method: .get, requestPayload: mockRequestPayload)
        URLProtocolMock.add(.data(mockResponseData), for: url(from: environment, endpoint))

        // WHEN
        await perform(endpoint)

        // THEN
        let request = try XCTUnwrap(URLProtocolMock.lastProcessedRequest)
        XCTAssertNil(request.bodyStreamData)
    }

    func test_perform_withoutRequestPayload() async throws {
        // GIVEN
        let endpoint = EndpointMock(method: .get)
        URLProtocolMock.add(.data(mockResponseData), for: url(from: environment, endpoint))

        // WHEN
        await perform(endpoint)

        // THEN
        let request = try XCTUnwrap(URLProtocolMock.lastProcessedRequest)
        XCTAssertNil(request.httpBodyStream)
    }

    func test_perform_withRequestPayload_whenEncodingFails_shouldReturnFailure() async throws {
        // GIVEN
        encoder.nonConformingFloatEncodingStrategy = .throw
        let invalidPayload = PayloadMock(value: .infinity)
        let endpoint = EndpointMock(method: .post, requestPayload: invalidPayload)
        URLProtocolMock.add(.data(mockResponseData), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.invalidRequest))
    }
}

// MARK: - Test Utils

private extension LiveNetworkClientTests {
    /// Load the response data from a JSON file.
    func responseData(from file: String) throws -> Data {
        let url = try XCTUnwrap(Bundle.module.url(forResource: file, withExtension: "json"))
        return try Data(contentsOf: url)
    }

    /// A util to perform the service call without having to save the result
    /// or specifying the expected type of the response payload.
    @discardableResult
    func perform(_ endpoint: EndpointMock) async -> Result<PayloadMock, NetworkError> {
        await client.perform(endpoint)
    }

    /// A util to create the URL from the combination of environment and endpoint.
    func url(from environment: APIEnvironment, _ endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = environment.scheme
        components.host = environment.host
        components.path = environment.path ?? ""
        components.queryItems = endpoint.parameters
        return components.url?.appendingPathExtension(endpoint.path)
    }
}
