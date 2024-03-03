import SwiftUI

/// Adds module navigation capabilities to a view.
public extension View {
    /// Pass all navigation destinations specific to a module to the specified module.
    /// - Parameter module: The module that should handle the navigation.
    /// - Returns: Self, with navigation destination applied, converted to AnyView.
    func navigation<M: Module>(module: M) -> AnyView {
        AnyView(navigationDestination(for: M.Destination.self, destination: module.navigation))
    }
}
