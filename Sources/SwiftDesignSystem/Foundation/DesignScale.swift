import SwiftUI

// MARK: - Design Scale
public enum DesignScale {

    // MARK: - Responsive Spacing
    public static func spacing(
        base: CGFloat,
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        horizontalSizeClass == .regular ? base * 1.5 : base
    }

    public static func fontScale(horizontalSizeClass: UserInterfaceSizeClass?) -> CGFloat {
        horizontalSizeClass == .regular ? 1.1 : 1.0
    }

    // MARK: - Grid Columns
    public static func gridColumns(
        availableWidth: CGFloat,
        minItemWidth: CGFloat = 150,
        spacing: CGFloat = DesignTokens.Spacing.md
    ) -> Int {
        let effectiveMin = minItemWidth + spacing
        return max(1, Int(availableWidth / effectiveMin))
    }

    // MARK: - Content Width
    public static func contentWidth(
        screenwidth: CGFloat,
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        if horizontalSizeClass == .regular {
            return min(screenwidth, DesignTokens.Sizing.iPadMaxWidth)
        }
        return screenwidth
    }

    // MARK: - Padding
    public static func horizontalPadding(
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        horizontalSizeClass == .regular
            ? DesignTokens.Spacing.xl
            : DesignTokens.Spacing.lg
    }

    public static func sectionPadding(
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        horizontalSizeClass == .regular
            ? DesignTokens.Spacing.xxl
            : DesignTokens.Spacing.xl
    }
}
