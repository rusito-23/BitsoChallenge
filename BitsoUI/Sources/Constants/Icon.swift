import Foundation

// MARK: - Icon

/// The available icons.
/// These are all based on SF Symbols at the moment.
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
