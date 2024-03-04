import BitsoKit
import BitsoNet
import SwiftUI
import Foundation

/// The ``BookModule`` live implementation.
public struct LiveBookModule: BookModule {

    // MARK: Properties

    private let dependencies: Dependencies

    // MARK: Public Initializer

    /// Create a books module.
    /// - Parameter dependencies: The dependencies needed to create a ``LiveBookModule``.
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: Navigation

    /// Creates the view from the given destination, transformed as `AnyView`.
    /// - Parameter destination: The ``BookDestination`` to be triggered.
    /// -  Returns: The view to be navigated to.
    @MainActor
    public func navigation(to destination: BookDestination) -> AnyView {
        navigationWrap(view(for: destination))
    }

    /// Creates the view from the given internal destination, transformed as `AnyView`.
    /// - Parameter destination: The `InternalBookDestination` to be triggered.
    /// -  Returns: The view to be navigated to.
    @MainActor
    private func internalNavigation(for destination: BookInternalDestination) -> AnyView {
        navigationWrap(internalView(for: destination))
    }

    // MARK: Private Methods

    /// Creates the view from the given public destination.
    /// - Parameter destination: The ``BookDestination`` to be triggered.
    /// -  Returns: The view to be navigated to.
    @ViewBuilder
    @MainActor
    private func view(for destination: BookDestination) -> some View {
        switch destination {
        case .bookList: BookListCoordinator(domain: dependencies.domain)
        }
    }

    /// Creates the view from the given internal destination.
    /// - Parameter destination: The `InternalBookDestination` to be triggered.
    /// -  Returns: The view to be navigated to.
    @ViewBuilder
    @MainActor
    private func internalView(for destination: BookInternalDestination) -> some View {
        switch destination {
        case let .bookDetail(id: bookID):
            BookDetailCoordinator(bookID: bookID, domain: dependencies.domain)
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

// MARK: - Dependencies

public extension LiveBookModule {
    /// Describes the dependencies needed to create a ``LiveBookModule``.
    struct Dependencies {
        let domain: DomainProvider

        public init(domain: DomainProvider) {
            self.domain = domain
        }
    }
}
