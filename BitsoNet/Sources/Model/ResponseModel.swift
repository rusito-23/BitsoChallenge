import Foundation

/// A basic generic response model.
/// This response represents the generic format that is expected from the service.
///
/// When the response succeeded, `success` is expected to be `true` and the payload to be included.
/// When the response fails, `success` is expected to be `false` and the payload is not included,
/// instead there will be an error code and message.
enum ResponseModel<Payload: Decodable>: Decodable {
    case success(Payload)
    case failure(message: String, code: Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let didSucceed = try container.decode(Bool.self, forKey: .success)

        if didSucceed {
            self = .success(try container.decode(Payload.self, forKey: .payload))
        } else {
            let error = try container.nestedContainer(keyedBy: ErrorKeys.self, forKey: .error)
            let message = try error.decode(String.self, forKey: .message)
            let code = try error.decode(Int.self, forKey: .code)
            self = .failure(message: message, code: code)
        }
    }
}

// MARK: - Coding Keys

private extension ResponseModel {
    enum CodingKeys: String, CodingKey {
        case success
        case payload
        case error
    }

    enum ErrorKeys: String, CodingKey {
        case message
        case code
    }
}
