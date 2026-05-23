import XCTest
@testable import SwiftDesignSystem
import SwiftUI

final class DesignTokensTests: XCTestCase {

    // MARK: - Spacing Tests
    func testSpacingValues() {
        XCTAssertEqual(DesignTokens.Spacing.tight, 2)
        XCTAssertEqual(DesignTokens.Spacing.xs, 4)
        XCTAssertEqual(DesignTokens.Spacing.sm, 8)
        XCTAssertEqual(DesignTokens.Spacing.md, 12)
        XCTAssertEqual(DesignTokens.Spacing.lg, 16)
        XCTAssertEqual(DesignTokens.Spacing.xl, 20)
        XCTAssertEqual(DesignTokens.Spacing.xxl, 24)
        XCTAssertEqual(DesignTokens.Spacing.xxxl, 32)
        XCTAssertEqual(DesignTokens.Spacing.huge, 48)
    }

    func testSpacingProgression() {
        let values: [CGFloat] = [
            DesignTokens.Spacing.tight,
            DesignTokens.Spacing.xs,
            DesignTokens.Spacing.sm,
            DesignTokens.Spacing.md,
            DesignTokens.Spacing.lg,
            DesignTokens.Spacing.xl,
            DesignTokens.Spacing.xxl,
            DesignTokens.Spacing.xxxl,
            DesignTokens.Spacing.huge
        ]
        for i in 0..<(values.count - 1) {
            XCTAssertLessThan(values[i], values[i + 1], "Spacing values should be monotonically increasing")
        }
    }

    // MARK: - Corner Radius Tests
    func testCornerRadiusValues() {
        XCTAssertEqual(DesignTokens.CornerRadius.sm, 8)
        XCTAssertEqual(DesignTokens.CornerRadius.md, 12)
        XCTAssertEqual(DesignTokens.CornerRadius.lg, 16)
        XCTAssertEqual(DesignTokens.CornerRadius.xl, 20)
        XCTAssertEqual(DesignTokens.CornerRadius.xxl, 24)
        XCTAssertEqual(DesignTokens.CornerRadius.full, 999)
    }

    // MARK: - Sizing Tests
    func testSizingValues() {
        XCTAssertEqual(DesignTokens.Sizing.buttonHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.textFieldHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.iPadMaxWidth, 700)
        XCTAssertEqual(DesignTokens.Sizing.linearProgressHeight, 6)
        XCTAssertEqual(DesignTokens.Sizing.bottomSheetMediumHeight, 400)
        XCTAssertEqual(DesignTokens.Sizing.bottomSheetLargeHeight, 600)
        XCTAssertEqual(DesignTokens.Sizing.dragIndicatorWidth, 36)
        XCTAssertEqual(DesignTokens.Sizing.dragIndicatorHeight, 5)
    }

    func testIconSizingProgression() {
        XCTAssertLessThan(DesignTokens.Sizing.iconSmall, DesignTokens.Sizing.iconMedium)
        XCTAssertLessThan(DesignTokens.Sizing.iconMedium, DesignTokens.Sizing.iconLarge)
        XCTAssertLessThan(DesignTokens.Sizing.iconLarge, DesignTokens.Sizing.iconXLarge)
        XCTAssertLessThan(DesignTokens.Sizing.iconXLarge, DesignTokens.Sizing.iconHero)
    }

    // MARK: - Border Tests
    func testBorderValues() {
        XCTAssertEqual(DesignTokens.Border.thin, 0.5)
        XCTAssertEqual(DesignTokens.Border.regular, 1)
        XCTAssertEqual(DesignTokens.Border.thick, 2)
    }

    // MARK: - Opacity Tests
    func testOpacityValues() {
        XCTAssertEqual(DesignTokens.Opacity.fullyVisible, 1.0)
        XCTAssertEqual(DesignTokens.Opacity.semiTransparent, 0.5)
        XCTAssertEqual(DesignTokens.Opacity.transparent, 0.25)
        XCTAssertEqual(DesignTokens.Opacity.shimmerOverlay, 0.3)
        XCTAssertEqual(DesignTokens.Opacity.textOnTint, 0.8)
    }

    func testOpacityRange() {
        let allOpacities: [Double] = [
            DesignTokens.Opacity.nearlyInvisible,
            DesignTokens.Opacity.veryTransparent,
            DesignTokens.Opacity.transparent,
            DesignTokens.Opacity.semiTransparent,
            DesignTokens.Opacity.barelyVisible,
            DesignTokens.Opacity.fullyVisible
        ]
        for opacity in allOpacities {
            XCTAssertGreaterThanOrEqual(opacity, 0.0)
            XCTAssertLessThanOrEqual(opacity, 1.0)
        }
    }

    // MARK: - Breakpoint Tests
    func testBreakpointCompactWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isCompact(width: 300))
        XCTAssertFalse(DesignTokens.Breakpoint.isCompact(width: 400))
    }

    func testBreakpointRegularWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isRegular(width: 400))
        XCTAssertFalse(DesignTokens.Breakpoint.isRegular(width: 800))
    }

    func testBreakpointTabletWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isTablet(width: 800))
        XCTAssertFalse(DesignTokens.Breakpoint.isTablet(width: 500))
    }

    func testBreakpointLargeTabletWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isLargeTablet(width: 1100))
        XCTAssertFalse(DesignTokens.Breakpoint.isLargeTablet(width: 900))
    }

    func testBreakpointMutualExclusivity() {
        let width: CGFloat = 300
        XCTAssertTrue(DesignTokens.Breakpoint.isCompact(width: width))
        XCTAssertFalse(DesignTokens.Breakpoint.isRegular(width: width))
        XCTAssertFalse(DesignTokens.Breakpoint.isTablet(width: width))
    }

    // MARK: - Shadow Tests
    func testShadowEquality() {
        let shadow1 = DesignShadow(color: .black, radius: 4, y: 2)
        let shadow2 = DesignShadow(color: .black, radius: 4, y: 2)
        XCTAssertEqual(shadow1, shadow2)
    }

    func testShadowInequality() {
        let shadow1 = DesignShadow(color: .black, radius: 4, y: 2)
        let shadow2 = DesignShadow(color: .black, radius: 8, y: 4)
        XCTAssertNotEqual(shadow1, shadow2)
    }

    func testPredefinedShadows() {
        XCTAssertEqual(DesignTokens.Shadows.subtle.radius, 4)
        XCTAssertEqual(DesignTokens.Shadows.medium.radius, 8)
        XCTAssertEqual(DesignTokens.Shadows.strong.radius, 16)
        XCTAssertEqual(DesignTokens.Shadows.cardTint.radius, 10)
    }

    func testShadowRadiusProgression() {
        XCTAssertLessThan(DesignTokens.Shadows.subtle.radius, DesignTokens.Shadows.medium.radius)
        XCTAssertLessThan(DesignTokens.Shadows.medium.radius, DesignTokens.Shadows.strong.radius)
    }

    // MARK: - Design Scale Tests
    func testGridColumns() {
        let columns = DesignScale.gridColumns(availableWidth: 400, minItemWidth: 150, spacing: 12)
        XCTAssertEqual(columns, 2)

        let tabletColumns = DesignScale.gridColumns(availableWidth: 800, minItemWidth: 150, spacing: 12)
        XCTAssertGreaterThanOrEqual(tabletColumns, 4)
    }

    func testGridColumnsMinimum() {
        let columns = DesignScale.gridColumns(availableWidth: 100, minItemWidth: 200, spacing: 12)
        XCTAssertEqual(columns, 1)
    }

    func testSpacingScale() {
        XCTAssertEqual(DesignScale.spacing(base: 16, horizontalSizeClass: .compact), 16)
        XCTAssertEqual(DesignScale.spacing(base: 16, horizontalSizeClass: .regular), 24)
    }

    func testFontScale() {
        XCTAssertEqual(DesignScale.fontScale(horizontalSizeClass: .compact), 1.0)
        XCTAssertEqual(DesignScale.fontScale(horizontalSizeClass: .regular), 1.1)
    }

    func testContentWidth() {
        let phoneWidth = DesignScale.contentWidth(screenwidth: 390, horizontalSizeClass: .compact)
        XCTAssertEqual(phoneWidth, 390)

        let tabletWidth = DesignScale.contentWidth(screenwidth: 1024, horizontalSizeClass: .regular)
        XCTAssertEqual(tabletWidth, DesignTokens.Sizing.iPadMaxWidth)
    }

    func testHorizontalPadding() {
        XCTAssertEqual(DesignScale.horizontalPadding(horizontalSizeClass: .compact), DesignTokens.Spacing.lg)
        XCTAssertEqual(DesignScale.horizontalPadding(horizontalSizeClass: .regular), DesignTokens.Spacing.xl)
    }

    func testSectionPadding() {
        XCTAssertEqual(DesignScale.sectionPadding(horizontalSizeClass: .compact), DesignTokens.Spacing.xl)
        XCTAssertEqual(DesignScale.sectionPadding(horizontalSizeClass: .regular), DesignTokens.Spacing.xxl)
    }

    // MARK: - Layer Tests
    func testLayerOrdering() {
        XCTAssertLessThan(DesignTokens.Layer.background, DesignTokens.Layer.content)
        XCTAssertLessThan(DesignTokens.Layer.content, DesignTokens.Layer.overlay)
        XCTAssertLessThan(DesignTokens.Layer.overlay, DesignTokens.Layer.modal)
        XCTAssertLessThan(DesignTokens.Layer.modal, DesignTokens.Layer.toast)
        XCTAssertLessThan(DesignTokens.Layer.toast, DesignTokens.Layer.tooltip)
    }

    // MARK: - Bottom Sheet Detent Tests
    func testBottomSheetDetentCases() {
        let medium = AppBottomSheetDetent.medium
        let large = AppBottomSheetDetent.large
        let custom = AppBottomSheetDetent.custom(300)

        if case .medium = medium { } else { XCTFail("Should be .medium") }
        if case .large = large { } else { XCTFail("Should be .large") }
        if case .custom(300) = custom { } else { XCTFail("Should be .custom(300)") }
    }

    // MARK: - Toast Style Tests
    func testToastStyleProperties() {
        XCTAssertFalse(AppToastStyle.success.icon.isEmpty)
        XCTAssertFalse(AppToastStyle.warning.icon.isEmpty)
        XCTAssertFalse(AppToastStyle.error.icon.isEmpty)
        XCTAssertFalse(AppToastStyle.info.icon.isEmpty)
    }

    // MARK: - Icon Typography Tests
    func testIconTypographyTokens() {
        XCTAssertNotNil(DesignTokens.IconTypography.small)
        XCTAssertNotNil(DesignTokens.IconTypography.medium)
        XCTAssertNotNil(DesignTokens.IconTypography.large)
        XCTAssertNotNil(DesignTokens.IconTypography.xLarge)
        XCTAssertNotNil(DesignTokens.IconTypography.hero)
        XCTAssertNotNil(DesignTokens.IconTypography.chevron)
        XCTAssertNotNil(DesignTokens.IconTypography.dismiss)
    }

    // MARK: - Typography Dynamic Type Tests
    func testTypographyTokensExist() {
        XCTAssertNotNil(DesignTokens.Typography.display)
        XCTAssertNotNil(DesignTokens.Typography.largeTitle)
        XCTAssertNotNil(DesignTokens.Typography.title)
        XCTAssertNotNil(DesignTokens.Typography.headline)
        XCTAssertNotNil(DesignTokens.Typography.body)
        XCTAssertNotNil(DesignTokens.Typography.caption)
        XCTAssertNotNil(DesignTokens.Typography.footnote)
        XCTAssertNotNil(DesignTokens.Typography.subheadline)
    }

    // MARK: - ProgressCalculation Tests
    func testProgressClamping() {
        XCTAssertEqual(ProgressCalculation.clamped(0.5), 0.5)
        XCTAssertEqual(ProgressCalculation.clamped(-0.5), 0.0)
        XCTAssertEqual(ProgressCalculation.clamped(1.5), 1.0)
        XCTAssertEqual(ProgressCalculation.clamped(0.0), 0.0)
        XCTAssertEqual(ProgressCalculation.clamped(1.0), 1.0)
    }

    func testProgressPercentageString() {
        XCTAssertEqual(ProgressCalculation.percentageString(0.65), "65%")
        XCTAssertEqual(ProgressCalculation.percentageString(0.0), "0%")
        XCTAssertEqual(ProgressCalculation.percentageString(1.0), "100%")
        XCTAssertEqual(ProgressCalculation.percentageString(-0.5), "0%")
        XCTAssertEqual(ProgressCalculation.percentageString(2.0), "100%")
    }

    func testProgressBarWidth() {
        XCTAssertEqual(ProgressCalculation.barWidth(fraction: 0.5, availableWidth: 200), 100)
        XCTAssertEqual(ProgressCalculation.barWidth(fraction: 0.0, availableWidth: 200), 0)
        XCTAssertEqual(ProgressCalculation.barWidth(fraction: 1.0, availableWidth: 200), 200)
    }

    // MARK: - CountFormatter Tests
    func testCountFormatterDisplayString() {
        XCTAssertEqual(CountFormatter.displayString(for: 5), "5")
        XCTAssertEqual(CountFormatter.displayString(for: 99), "99")
        XCTAssertEqual(CountFormatter.displayString(for: 100), "99+")
        XCTAssertEqual(CountFormatter.displayString(for: 999), "99+")
    }

    func testCountFormatterAccessibility() {
        XCTAssertEqual(CountFormatter.accessibilityString(for: 5), "5 items")
        XCTAssertEqual(CountFormatter.accessibilityString(for: 100), "More than 99 items")
    }

    // MARK: - DimensionCalculation Tests
    func testGridColumnCount() {
        XCTAssertEqual(DimensionCalculation.gridColumnCount(availableWidth: 400, minItemWidth: 150, spacing: 12), 2)
        XCTAssertEqual(DimensionCalculation.gridColumnCount(availableWidth: 100, minItemWidth: 200, spacing: 12), 1)
        XCTAssertEqual(DimensionCalculation.gridColumnCount(availableWidth: 800, minItemWidth: 150, spacing: 12), 4)
    }

    func testCappedWidth() {
        XCTAssertEqual(DimensionCalculation.cappedWidth(width: 1024, maxWidth: 700), 700)
        XCTAssertEqual(DimensionCalculation.cappedWidth(width: 390, maxWidth: 700), 390)
    }

    func testSkeletonLineWidth() {
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: 0.5), 100)
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: 1.0), 200)
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: 0.0), 0)
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: -0.5), 0)
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: 1.5), 200)
    }

    func testDialogMaxWidth() {
        XCTAssertEqual(DimensionCalculation.dialogMaxWidth(screenMaxWidth: 700, horizontalPadding: 32), 636)
    }

    // MARK: - StyleResolution Tests
    func testSelectionBackground() {
        let active = StyleResolution.selectionBackground(isSelected: true, activeColor: .blue)
        XCTAssertEqual(active, .blue)
        let inactive = StyleResolution.selectionBackground(isSelected: false, activeColor: .blue)
        XCTAssertEqual(inactive, Color.clear)
    }

    func testDisabledOpacity() {
        XCTAssertEqual(StyleResolution.disabledOpacity(isDisabled: true), DesignTokens.Opacity.semiTransparent)
        XCTAssertEqual(StyleResolution.disabledOpacity(isDisabled: false), DesignTokens.Opacity.fullyVisible)
    }

    func testSelectionLabel() {
        XCTAssertEqual(StyleResolution.selectionLabel(isSelected: true), SystemStrings.Accessibility.selected)
        XCTAssertEqual(StyleResolution.selectionLabel(isSelected: false), SystemStrings.Accessibility.notSelected)
    }

    func testToggleLabel() {
        XCTAssertEqual(StyleResolution.toggleLabel(isOn: true), SystemStrings.Accessibility.toggleOn)
        XCTAssertEqual(StyleResolution.toggleLabel(isOn: false), SystemStrings.Accessibility.toggleOff)
    }

    func testFieldBorderColor() {
        XCTAssertEqual(StyleResolution.fieldBorderColor(hasError: true), DesignTokens.Colors.danger)
        XCTAssertEqual(StyleResolution.fieldBorderColor(hasError: false), DesignTokens.Colors.separator)
    }

    func testSelectionBorderWidth() {
        XCTAssertEqual(StyleResolution.selectionBorderWidth(isSelected: true), DesignTokens.Border.thick)
        XCTAssertEqual(StyleResolution.selectionBorderWidth(isSelected: false), DesignTokens.Border.thin)
    }

    func testSelectionIndicatorIcon() {
        XCTAssertEqual(StyleResolution.selectionIndicatorIcon(isSelected: true), SystemStrings.StateIcons.selectedIndicator)
        XCTAssertEqual(StyleResolution.selectionIndicatorIcon(isSelected: false), SystemStrings.StateIcons.unselectedIndicator)
    }
}
