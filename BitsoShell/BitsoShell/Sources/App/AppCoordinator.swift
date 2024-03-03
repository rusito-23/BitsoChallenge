import BitsoBookModule
import BitsoKit
import BitsoUI
import BitsoNet
import SwiftUI

struct AppCoordinator: View {

    // MARK: Observed Properties

    @ObservedObject var router = Router()

    // MARK: Modules

    private let booksModule: any BookModule

    // MARK: Initializer

    init(booksModule: any BookModule = LiveBookModule(domain: Environment.sandbox)) {
        self.booksModule = booksModule
    }

    // MARK: Body

    var body: some View {
        NavigationStack(path: $router.path) {
            RootView()
                .navigation(module: booksModule)
        }
        .environmentObject(router)
    }
}
