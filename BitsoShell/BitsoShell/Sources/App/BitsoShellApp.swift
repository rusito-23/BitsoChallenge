import SwiftUI

@main
struct BitsoShellApp: App {
    private let environment: AppEnvironment = .sandbox

    var body: some Scene {
        WindowGroup {
            AppCoordinator(environment: environment)
        }
    }
}
