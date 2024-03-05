import BitsoNet

enum EnvironmentMock: APIEnvironment {
    case mock

    var scheme: String {
        "scheme"
    }

    var host: String {
        "host"
    }

    var path: String? {
        "path"
    }
}
