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
        navigationWrap(coordinator(for: destination))
    }

    /// Creates the view from the given internal destination, transformed as `AnyView`.
    /// - Parameter destination: The `InternalBookDestination` to be triggered.
    /// -  Returns: The view to be navigated to.
    @MainActor
    func internalNavigation(for destination: BookInternalDestination) -> AnyView {
        navigationWrap(internalCoordinator(for: destination))
    }
}

// MARK: - Private Methods

private extension LiveBookModule {
    /// Create the coordinator for a public destination.
    @ViewBuilder
    @MainActor
    private func coordinator(for destination: BookDestination) -> some View {
        switch destination {
        case .bookList: BookListCoordinator(environment: environment)
        }
    }

    /// Create the coordinator for an internal destination.
    @ViewBuilder
    @MainActor
    private func internalCoordinator(for destination: BookInternalDestination) -> some View {
        switch destination {
        case let .bookDetails(id: bookID):
            BookDetailsCoordinator(bookID: bookID, environment: environment)
        }
    }

    /// Wraps all navigation destination views to support internal navigation into `AnyView`.
    @MainActor
    private func navigationWrap(_ view: any View) -> AnyView {
        AnyView(
            view.navigationDestination(for: BookInternalDestination.self) {
                internalNavigation(for: $0)
            }
        )
    }
}
