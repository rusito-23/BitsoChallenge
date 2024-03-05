import SwiftUI

/// Display a system icon with a given size.
public struct IconView: View {
    private let icon: Icon
    private let size: IconSize

    /// Create a new icon view.
    /// - Parameter icon: The ``Icon`` to be displayed.
    /// - Parameter size: The ``IconSize`` to resize the view.
    public init(icon: Icon, size: IconSize) {
        self.icon = icon
        self.size = size
    }

    public var body: some View {
        Image(systemName: icon.rawValue)
            .resizable()
            .frame(width: size.rawValue, height: size.rawValue)
    }
}

// MARK: - Previews

#if DEBUG
@available(*, unavailable)
struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack {
                IconView(icon: .magnifyingGlass, size: .small)
                IconView(icon: .magnifyingGlass, size: .medium)
                IconView(icon: .magnifyingGlass, size: .large)
            }
            VStack {
                IconView(icon: .error, size: .small)
                IconView(icon: .error, size: .medium)
                IconView(icon: .error, size: .large)
            }
        }
    }
}
#endif
