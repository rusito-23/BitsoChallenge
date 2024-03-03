import SwiftUI

// MARK: - App

@main
struct BitsoShellApp: App {

    // MARK: Properties

    private let configuration: Configuration

    // MARK: Initializer

    init() {
        self.configuration = Configuration(environment: .sandbox)
    }

    // MARK: App Conformance

    var body: some Scene {
        WindowGroup {
            AppCoordinator(configuration: configuration)
        }
    }
}

// MARK: - App Configuration

class Configuration {
    let environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }
}
