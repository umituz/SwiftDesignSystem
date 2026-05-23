import SwiftUI

// MARK: - Design Scale
public enum DesignScale {

    // MARK: - Responsive Spacing
    public static func spacing(
        base: CGFloat,
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        AdaptiveValue(compact: base, regular: base * 1.5)
            .resolve(for: horizontalSizeClass)
    }

    public static func fontScale(horizontalSizeClass: UserInterfaceSizeClass?) -> CGFloat {
        AdaptiveValue(compact: 1.0, regular: 1.1)
            .resolve(for: horizontalSizeClass)
    }

    // MARK: - Grid Columns
    public static func gridColumns(
        availableWidth: CGFloat,
        minItemWidth: CGFloat = 150,
        spacing: CGFloat = DesignTokens.Spacing.md
    ) -> Int {
        DimensionCalculation.gridColumnCount(
            availableWidth: availableWidth,
            minItemWidth: minItemWidth,
            spacing: spacing
        )
    }

    // MARK: - Content Width
    public static func contentWidth(
        screenwidth: CGFloat,
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        if horizontalSizeClass == .regular {
            return DimensionCalculation.cappedWidth(width: screenwidth, maxWidth: DesignTokens.Sizing.iPadMaxWidth)
        }
        return screenwidth
    }

    // MARK: - Padding
    public static func horizontalPadding(
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        AdaptiveValue(compact: DesignTokens.Spacing.lg, regular: DesignTokens.Spacing.xl)
            .resolve(for: horizontalSizeClass)
    }

    public static func sectionPadding(
        horizontalSizeClass: UserInterfaceSizeClass?
    ) -> CGFloat {
        AdaptiveValue(compact: DesignTokens.Spacing.xl, regular: DesignTokens.Spacing.xxl)
            .resolve(for: horizontalSizeClass)
    }
}
