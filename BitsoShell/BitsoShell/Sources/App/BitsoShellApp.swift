import SwiftUI

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
