import Foundation

/// A collection of constants to style component borders.
public struct Border {
    /// Determines the width of the border, from light to bold.
    public enum Width: CGFloat {
        /// 0.5
        case light = 0.5

        /// 1
        case regular = 1.0

        /// 2
        case bold = 2.0
    }

    /// Determines the radius of the border.
    public enum Radius: CGFloat {
        /// 10
        case small = 10.0

        /// 20
        case medium = 20.0

        /// 50
        case large = 50.0
    }
}
