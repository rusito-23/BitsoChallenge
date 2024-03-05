import BitsoKit
import BitsoNet
import SwiftUI
import Foundation

/// The ``BookModule`` live implementation.
public struct LiveBookModule: BookModule {
    private let environment: APIEnvironment

    /// Create the book module.
    /// - Parameter environment: The environment provider, required to perform service calls.
    public init(environment: APIEnvironment) {
        self.environment = environment
    }
}

// MARK: Navigation

extension LiveBookModule {
    /// Creates the content for the given destination, transformed as `AnyView`.
    /// - Parameter destination: The ``BookDestination`` to be triggered.
    /// -  Returns: The content to be navigated to.
    @MainActor
    public func navigation(to destination: BookDestination) -> AnyView {
        AnyView(coordinator(for: destination))
    }

    /// Create the coordinator for a public destination.
    @ViewBuilder
    @MainActor
    func coordinator(for destination: BookDestination) -> some View {
        switch destination {
        case .bookList: BookListCoordinator(environment: environment)
        }
    }
}
