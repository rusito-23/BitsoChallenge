import BitsoNet
import XCTest

final class LiveNetworkClientTests: XCTestCase {

    // MARK: Properties

    private var encoder: JSONEncoder!
    private var decoder: JSONDecoder!

    private var requestPayload: PayloadMock!
    private var requestPayloadData: Data!

    private var responsePayload: PayloadMock!
    private var responsePayloadData: Data!

    private var client: LiveNetworkClient!

    // MARK: Constants

    private let environment = DomainMock.valid
    private let endpoint = EndpointMock(method: .post)

    // MARK: Set up

    override func setUp() async throws {
        try await super.setUp()

        encoder = JSONEncoder()
        decoder = JSONDecoder()

        requestPayload = PayloadMock()
        requestPayloadData = try encoder.encode(requestPayload)

        responsePayload = PayloadMock()
        responsePayloadData = try encoder.encode(responsePayload)

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

    // MARK: Tests

    func test_perform_withValidPayload_shouldSucceed() async throws {
        // GIVEN
        URLProtocolMock.add(.data(responsePayloadData), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .success(responsePayload))
    }

    func test_perform_withInvalidURL_shouldFail() async {
        // GIVEN
        client = LiveNetworkClient(
            environment: DomainMock.invalid,
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
        URLProtocolMock.add(.data(responsePayloadData), for: url(from: environment, endpoint))

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
        URLProtocolMock.add(.data(responsePayloadData), for: url(from: environment, endpoint))

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
        let endpoint = EndpointMock(method: .post, requestPayload: requestPayload)
        URLProtocolMock.add(.data(responsePayloadData), for: url(from: environment, endpoint))

        // WHEN
        await perform(endpoint)

        // THEN
        let request = try XCTUnwrap(URLProtocolMock.lastProcessedRequest)
        let data = try XCTUnwrap(request.bodyStreamData)
        XCTAssertEqual(requestPayload, try decoder.decode(PayloadMock.self, from: data))
    }

    func test_perform_withRequestPayload_whenMethodDoesNotSupportPayload() async throws {
        // GIVEN
        let endpoint = EndpointMock(method: .get, requestPayload: requestPayload)
        URLProtocolMock.add(.data(responsePayloadData), for: url(from: environment, endpoint))

        // WHEN
        await perform(endpoint)

        // THEN
        let request = try XCTUnwrap(URLProtocolMock.lastProcessedRequest)
        XCTAssertNil(request.bodyStreamData)
    }

    func test_perform_withoutRequestPayload() async throws {
        // GIVEN
        let endpoint = EndpointMock(method: .get)
        URLProtocolMock.add(.data(responsePayloadData), for: url(from: environment, endpoint))

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
        URLProtocolMock.add(.data(responsePayloadData), for: url(from: environment, endpoint))

        // WHEN
        let result = await perform(endpoint)

        // THEN
        XCTAssertEqual(result, .failure(.invalidRequest))
    }
}

// MARK: - Test Utils

private extension LiveNetworkClientTests {
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
