import BitsoNet
import Foundation

enum Environment {
    case sandbox
}

// MARK: - Domain Provider Conformance

extension Environment: Domain {
    /// All environments should use HTTPS.
    var scheme: String {
        "https"
    }

    /// The host depends on the selected environment.
    var host: String {
        switch self {
        case .sandbox: return "sandbox.bitso.com"
        }
    }

    /// All environments will use the v3 API.
    var path: String? {
        "/api/v3"
    }
}
