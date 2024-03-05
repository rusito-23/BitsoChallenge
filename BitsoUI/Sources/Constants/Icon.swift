import Foundation

// MARK: - Icon

/// The available icons, based on System SF Symbols.
public enum Icon: String {
    case magnifyingGlass = "magnifyingglass"
    case error = "exclamationmark.triangle.fill"
}

// MARK: - Icon Size

public enum IconSize: CGFloat {
    /// 32
    case small = 32

    /// 48
    case medium = 48

    /// 64
    case large = 64
}
