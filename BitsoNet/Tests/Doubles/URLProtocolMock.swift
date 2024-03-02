import BitsoNet
import Foundation

/// A mock version of URL protocol.
///
/// Unfortunately, since `URLSession` is based around a Singleton
/// and doesn't provide a `Protocol` to mock its methods, we need to follow its similar pattern.
///
/// This stub allows two basic functionalities:
/// - add rules to stub different network calls with errors, responses and data.
/// - exposes the last processed request, so that its values can be verified in the unit tests.
final class URLProtocolMock: URLProtocol {

    // MARK: Rule Kinds

    enum Rule {
        case error(Error)
        case data(Data)
        case response(statusCode: Int)
    }

    // MARK: Properties

    /// The last processed request.
    static var lastProcessedRequest: URLRequest?

    /// The collection of rules of the endpoints to be stubbed.
    static var rules: [URL: Rule] = [:]

    // MARK: Private Static Methods

    /// Add a new rule.
    static func add(_ rule: Rule, for url: URL?) {
        if let url {
            rules[url] = rule
        }
    }

    /// Remove all rules.
    static func clear() {
        rules = [:]
    }

    // MARK: URLProtocol Overrides

    override class func canInit(with request: URLRequest) -> Bool {
        // Allow all kind of requests.
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Required method.
        request
    }

    override func startLoading() {
        defer {
            // Always save the request to verify its values.
            Self.lastProcessedRequest = request

            // Always notify that we finished loading before returning.
            client?.urlProtocolDidFinishLoading(self)
        }

        guard let url = request.url, let rule = Self.rules[url] else {
            // We don't have a rule set up for this URL.
            client?.urlProtocol(self, didFailWithError: ServiceError.invalidRequest)
            return
        }

        switch rule {
        case let .error(error):
            client?.urlProtocol(self, didFailWithError: error)
        case let .data(data):
            guard let response = HTTPURLResponse(url: url, statusCode: 200) else { return }
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        case let .response(statusCode: statusCode):
            guard let response = HTTPURLResponse(url: url, statusCode: statusCode) else { return }
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
    }

    override func stopLoading() {
        // Required method.
    }
}

// MARK: - Response Extensions

private extension HTTPURLResponse {
    convenience init?(url: URL, statusCode: Int) {
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}
