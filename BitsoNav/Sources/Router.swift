import SwiftUI
import Foundation

/// A router that helps drive the stack navigation.
///
/// Usage:
/// ```
/// @ObservedObject var router = Router()
/// var body: some View {
///     NavigationStack(path: $router.navPath) {
///         ...
///     }
///     .environmentObject(router)
/// }
/// ```
public final class Router: ObservableObject {

    // MARK: Properties

    /// The published navigation path.
    @Published public var path: NavigationPath

    // MARK: Initializer

    /// Create a new router.
    /// - Parameter path: The navigation path. Empty path by default.
    public init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }

    // MARK: Methods

    /// Navigate to a new destination.
    /// - Parameter destination: The destination to be added to the path.
    public func navigate(to destination: any Hashable) {
        path.append(destination)
    }

    /// Pop the last destination from the navigation stack.
    public func pop() {
        path.removeLast()
    }

    /// Pop all destinations from the navigation stack.
    public func popToRoot() {
        path.removeLast(path.count)
    }
}
