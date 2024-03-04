import SwiftUI

public extension EdgeInsets {
    /// Create EdgeInsets using ``Spacing``.
    init(top: Spacing, leading: Spacing, bottom: Spacing, trailing: Spacing) {
        self.init(
            top: top.rawValue,
            leading: leading.rawValue,
            bottom: bottom.rawValue,
            trailing: trailing.rawValue
        )
    }

    /// Create uniform EdgeInsets using ``Spacing``.
    init(spacing: Spacing) {
        self.init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
    }
}
