import BitsoBookModule
import BitsoKit
import BitsoUI
import BitsoNet
import SwiftUI

struct AppCoordinator: View {

    // MARK: Observed Properties

    @ObservedObject var router = Router()

    // MARK: Modules

    private let bookModule: any BookModule

    // MARK: Initializers

    init(bookModule: any BookModule) {
        self.bookModule = bookModule
    }

    init(configuration: Configuration) {
        self.bookModule = LiveBookModule(dependencies: .init(domain: configuration.environment))
    }

    // MARK: Body

    var body: some View {
        NavigationStack(path: $router.path) {
            RootView()
                .navigation(module: bookModule)
        }
        .environmentObject(router)
    }
}
