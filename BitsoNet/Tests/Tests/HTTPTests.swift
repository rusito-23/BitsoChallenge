import XCTest
@testable import BitsoNet

final class HTTPTests: XCTestCase {
    func testContentTypeHeaders() {
        let contentTypeJSON: HTTP.Headers.ContentType = .json
        XCTAssertEqual(contentTypeJSON.key, "Content-Type")
        XCTAssertEqual(contentTypeJSON.value, "application/json")
    }

    func testMethods() {
        let methods: [HTTP.Method] = [
            .get,
            .put,
            .post,
            .patch,
        ]

        XCTAssertEqual(methods.map(\.rawValue), [
            "GET",
            "PUT",
            "POST",
            "PATCH",
        ])

        XCTAssertEqual(methods.map(\.supportsPayload), [
            false,
            true,
            true,
            true,
        ])
    }

    func testStatus() {
        let statusCodeRanges: [ClosedRange<Int>: HTTP.Status] = [
            (100...199): .info,
            (200...299): .success,
            (300...399): .redirect,
            (400...499): .client,
            (500...599): .server,
            (600...999): .unknown,
        ]

        for (range, status) in statusCodeRanges {
            for statusCode in range {
                XCTAssertEqual(HTTP.Status(statusCode), status)
            }
        }
    }
}
