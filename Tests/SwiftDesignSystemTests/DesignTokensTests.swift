import XCTest
@testable import SwiftDesignSystem
import SwiftUI

final class DesignTokensTests: XCTestCase {

    // MARK: - Spacing

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
        let values = [
            DesignTokens.Spacing.tight, DesignTokens.Spacing.xs,
            DesignTokens.Spacing.sm, DesignTokens.Spacing.md,
            DesignTokens.Spacing.lg, DesignTokens.Spacing.xl,
            DesignTokens.Spacing.xxl, DesignTokens.Spacing.xxxl,
            DesignTokens.Spacing.huge
        ]
        for idx in 0..<(values.count - 1) {
            XCTAssertLessThan(values[idx], values[idx + 1])
        }
    }

    func testSpacingAllPositive() {
        let all: [CGFloat] = [
            DesignTokens.Spacing.tight, DesignTokens.Spacing.xs,
            DesignTokens.Spacing.sm, DesignTokens.Spacing.md,
            DesignTokens.Spacing.lg, DesignTokens.Spacing.xl,
            DesignTokens.Spacing.xxl, DesignTokens.Spacing.xxxl,
            DesignTokens.Spacing.huge
        ]
        for spacing in all { XCTAssertGreaterThan(spacing, 0) }
    }

    // MARK: - Corner Radius

    func testCornerRadiusValues() {
        XCTAssertEqual(DesignTokens.CornerRadius.sm, 8)
        XCTAssertEqual(DesignTokens.CornerRadius.md, 12)
        XCTAssertEqual(DesignTokens.CornerRadius.lg, 16)
        XCTAssertEqual(DesignTokens.CornerRadius.xl, 20)
        XCTAssertEqual(DesignTokens.CornerRadius.xxl, 24)
        XCTAssertEqual(DesignTokens.CornerRadius.full, 999)
    }

    func testCornerRadiusProgression() {
        XCTAssertLessThan(DesignTokens.CornerRadius.sm, DesignTokens.CornerRadius.md)
        XCTAssertLessThan(DesignTokens.CornerRadius.md, DesignTokens.CornerRadius.lg)
        XCTAssertLessThan(DesignTokens.CornerRadius.lg, DesignTokens.CornerRadius.xl)
        XCTAssertLessThan(DesignTokens.CornerRadius.xl, DesignTokens.CornerRadius.xxl)
    }

    // MARK: - Sizing

    func testComponentSizingValues() {
        XCTAssertEqual(DesignTokens.Sizing.buttonHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.textFieldHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.searchBarHeight, 36)
        XCTAssertEqual(DesignTokens.Sizing.toggleHeight, 31)
        XCTAssertEqual(DesignTokens.Sizing.checkboxSize, 24)
        XCTAssertEqual(DesignTokens.Sizing.sliderTrackHeight, 4)
        XCTAssertEqual(DesignTokens.Sizing.sliderThumbSize, 28)
        XCTAssertEqual(DesignTokens.Sizing.tabHeight, 44)
        XCTAssertEqual(DesignTokens.Sizing.accordionMinHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.dropdownHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.formSectionSpacing, 24)
    }

    func testLayoutSizingValues() {
        XCTAssertEqual(DesignTokens.Sizing.iPadMaxWidth, 700)
        XCTAssertEqual(DesignTokens.Sizing.maxContentWidth, 900)
        XCTAssertEqual(DesignTokens.Sizing.maxCardWidth, 650)
        XCTAssertEqual(DesignTokens.Sizing.linearProgressHeight, 6)
        XCTAssertEqual(DesignTokens.Sizing.bottomSheetMediumHeight, 400)
        XCTAssertEqual(DesignTokens.Sizing.bottomSheetLargeHeight, 600)
    }

    func testIconSizingProgression() {
        XCTAssertLessThan(DesignTokens.Sizing.iconSmall, DesignTokens.Sizing.iconMedium)
        XCTAssertLessThan(DesignTokens.Sizing.iconMedium, DesignTokens.Sizing.iconLarge)
        XCTAssertLessThan(DesignTokens.Sizing.iconLarge, DesignTokens.Sizing.iconXLarge)
        XCTAssertLessThan(DesignTokens.Sizing.iconXLarge, DesignTokens.Sizing.iconHero)
    }

    // MARK: - Border

    func testBorderValues() {
        XCTAssertEqual(DesignTokens.Border.thin, 0.5)
        XCTAssertEqual(DesignTokens.Border.regular, 1)
        XCTAssertEqual(DesignTokens.Border.thick, 2)
    }

    func testBorderProgression() {
        XCTAssertLessThan(DesignTokens.Border.thin, DesignTokens.Border.regular)
        XCTAssertLessThan(DesignTokens.Border.regular, DesignTokens.Border.thick)
    }

    // MARK: - Opacity

    func testOpacityValues() {
        XCTAssertEqual(DesignTokens.Opacity.fullyVisible, 1.0)
        XCTAssertEqual(DesignTokens.Opacity.semiTransparent, 0.5)
        XCTAssertEqual(DesignTokens.Opacity.transparent, 0.25)
        XCTAssertEqual(DesignTokens.Opacity.shimmerOverlay, 0.3)
        XCTAssertEqual(DesignTokens.Opacity.textOnTint, 0.8)
    }

    func testOpacityRange() {
        let all: [Double] = [
            DesignTokens.Opacity.nearlyInvisible, DesignTokens.Opacity.veryTransparent,
            DesignTokens.Opacity.transparent, DesignTokens.Opacity.semiTransparent,
            DesignTokens.Opacity.barelyVisible, DesignTokens.Opacity.fullyVisible
        ]
        for opacity in all {
            XCTAssertGreaterThanOrEqual(opacity, 0.0)
            XCTAssertLessThanOrEqual(opacity, 1.0)
        }
    }

    // MARK: - Breakpoints

    func testBreakpointCompactWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isCompact(width: 300))
        XCTAssertFalse(DesignTokens.Breakpoint.isCompact(width: 375))
    }

    func testBreakpointRegularWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isRegular(width: 400))
        XCTAssertTrue(DesignTokens.Breakpoint.isRegular(width: 375))
        XCTAssertFalse(DesignTokens.Breakpoint.isRegular(width: 800))
    }

    func testBreakpointTabletWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isTablet(width: 768))
        XCTAssertFalse(DesignTokens.Breakpoint.isTablet(width: 500))
    }

    func testBreakpointLargeTabletWidth() {
        XCTAssertTrue(DesignTokens.Breakpoint.isLargeTablet(width: 1024))
        XCTAssertFalse(DesignTokens.Breakpoint.isLargeTablet(width: 900))
    }

    // MARK: - Shadow

    func testShadowInit() {
        let shadow = DesignShadow(color: .red, radius: 10, y: 5)
        XCTAssertEqual(shadow.radius, 10)
        XCTAssertEqual(shadow.y, 5)
    }

    func testShadowEquality() {
        let s1 = DesignShadow(color: .black, radius: 4, y: 2)
        let s2 = DesignShadow(color: .black, radius: 4, y: 2)
        XCTAssertEqual(s1, s2)
    }

    func testShadowInequality() {
        let s1 = DesignShadow(color: .black, radius: 4, y: 2)
        let s2 = DesignShadow(color: .black, radius: 8, y: 4)
        XCTAssertNotEqual(s1, s2)
    }

    func testPredefinedShadows() {
        XCTAssertEqual(DesignTokens.Shadows.subtle.radius, 4)
        XCTAssertEqual(DesignTokens.Shadows.medium.radius, 8)
        XCTAssertEqual(DesignTokens.Shadows.strong.radius, 16)
        XCTAssertEqual(DesignTokens.Shadows.cardTint.radius, 10)
    }

    // MARK: - Layer

    func testLayerOrdering() {
        XCTAssertLessThan(DesignTokens.Layer.background, DesignTokens.Layer.content)
        XCTAssertLessThan(DesignTokens.Layer.content, DesignTokens.Layer.overlay)
        XCTAssertLessThan(DesignTokens.Layer.overlay, DesignTokens.Layer.modal)
        XCTAssertLessThan(DesignTokens.Layer.modal, DesignTokens.Layer.toast)
        XCTAssertLessThan(DesignTokens.Layer.toast, DesignTokens.Layer.tooltip)
    }

    // MARK: - ProgressCalculation

    func testProgressClamping() {
        XCTAssertEqual(ProgressCalculation.clamped(0.5), 0.5)
        XCTAssertEqual(ProgressCalculation.clamped(-0.5), 0.0)
        XCTAssertEqual(ProgressCalculation.clamped(1.5), 1.0)
        XCTAssertEqual(ProgressCalculation.clamped(0.0), 0.0)
    }

    func testProgressPercentageString() {
        XCTAssertEqual(ProgressCalculation.percentageString(0.65), "65%")
        XCTAssertEqual(ProgressCalculation.percentageString(0.0), "0%")
        XCTAssertEqual(ProgressCalculation.percentageString(1.0), "100%")
        XCTAssertEqual(ProgressCalculation.percentageString(-0.5), "0%")
    }

    func testProgressAccessibility() {
        XCTAssertEqual(ProgressCalculation.accessibilityPercentString(0.5), "50 percent")
        XCTAssertEqual(ProgressCalculation.accessibilityPercentString(1.0), "100 percent")
    }

    func testProgressBarWidth() {
        XCTAssertEqual(ProgressCalculation.barWidth(fraction: 0.5, availableWidth: 200), 100)
        XCTAssertEqual(ProgressCalculation.barWidth(fraction: 0.0, availableWidth: 200), 0)
        XCTAssertEqual(ProgressCalculation.barWidth(fraction: 2.0, availableWidth: 200), 200)
    }

    // MARK: - CountFormatter

    func testCountFormatterDisplay() {
        XCTAssertEqual(CountFormatter.displayString(for: 0), "0")
        XCTAssertEqual(CountFormatter.displayString(for: 99), "99")
        XCTAssertEqual(CountFormatter.displayString(for: 100), "99+")
    }

    func testCountFormatterAccessibility() {
        XCTAssertEqual(CountFormatter.accessibilityString(for: 5), "5 items")
        XCTAssertEqual(CountFormatter.accessibilityString(for: 100), "More than 99 items")
    }

    // MARK: - DimensionCalculation

    func testGridColumnCount() {
        XCTAssertEqual(DimensionCalculation.gridColumnCount(availableWidth: 400, minItemWidth: 150, spacing: 12), 2)
        XCTAssertEqual(DimensionCalculation.gridColumnCount(availableWidth: 0, minItemWidth: 150, spacing: 12), 1)
    }

    func testCappedWidth() {
        XCTAssertEqual(DimensionCalculation.cappedWidth(width: 1024, maxWidth: 700), 700)
        XCTAssertEqual(DimensionCalculation.cappedWidth(width: 390, maxWidth: 700), 390)
    }

    func testSkeletonLineWidth() {
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: 0.5), 100)
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: -0.5), 0)
        XCTAssertEqual(DimensionCalculation.skeletonLineWidth(containerWidth: 200, ratio: 1.5), 200)
    }

    func testDialogMaxWidth() {
        let result = DimensionCalculation.dialogMaxWidth(screenMaxWidth: 700, horizontalPadding: 32)
        XCTAssertEqual(result, 636)
    }

    // MARK: - AdaptiveValue

    func testAdaptiveValueCompact() {
        let value = AdaptiveValue(compact: 10, regular: 20)
        XCTAssertEqual(value.resolve(for: .compact), 10)
    }

    func testAdaptiveValueRegular() {
        let value = AdaptiveValue(compact: 10, regular: 20)
        XCTAssertEqual(value.resolve(for: .regular), 20)
    }

    func testAdaptiveValueNil() {
        let value = AdaptiveValue(compact: 10, regular: 20)
        XCTAssertEqual(value.resolve(for: nil), 10)
    }

    func testAdaptiveValueConstant() {
        let value = AdaptiveValue<Int>.constant(42)
        XCTAssertEqual(value.resolve(for: .compact), 42)
        XCTAssertEqual(value.resolve(for: .regular), 42)
    }

    // MARK: - DesignScale

    func testSpacingScale() {
        XCTAssertEqual(DesignScale.spacing(base: 16, horizontalSizeClass: .compact), 16)
        XCTAssertEqual(DesignScale.spacing(base: 16, horizontalSizeClass: .regular), 24)
    }

    func testContentWidth() {
        XCTAssertEqual(DesignScale.contentWidth(screenWidth: 390, horizontalSizeClass: .compact), 390)
        let tablet = DesignScale.contentWidth(screenWidth: 1024, horizontalSizeClass: .regular)
        XCTAssertEqual(tablet, DesignTokens.Sizing.iPadMaxWidth)
    }

    func testHorizontalPadding() {
        XCTAssertEqual(DesignScale.horizontalPadding(horizontalSizeClass: .compact), DesignTokens.Spacing.lg)
        XCTAssertEqual(DesignScale.horizontalPadding(horizontalSizeClass: .regular), DesignTokens.Spacing.xl)
    }

    // MARK: - StyleResolution

    func testSelectionBackground() {
        XCTAssertEqual(StyleResolution.selectionBackground(isSelected: true, activeColor: .blue), .blue)
        XCTAssertEqual(StyleResolution.selectionBackground(isSelected: false, activeColor: .blue), .clear)
    }

    func testDisabledOpacity() {
        XCTAssertEqual(StyleResolution.disabledOpacity(isDisabled: true), 0.5)
        XCTAssertEqual(StyleResolution.disabledOpacity(isDisabled: false), 1.0)
    }

    func testFieldBorderColor() {
        XCTAssertEqual(StyleResolution.fieldBorderColor(hasError: true), DesignTokens.Colors.danger)
        XCTAssertEqual(StyleResolution.fieldBorderColor(hasError: false), DesignTokens.Colors.separator)
    }

    func testCheckboxIcon() {
        XCTAssertEqual(StyleResolution.checkboxIcon(isChecked: true), SystemStrings.StateIcons.checkboxChecked)
        XCTAssertEqual(StyleResolution.checkboxIcon(isChecked: false), SystemStrings.StateIcons.checkboxUnchecked)
    }

    func testAccordionChevron() {
        XCTAssertEqual(StyleResolution.accordionChevron(isExpanded: true), SystemStrings.StateIcons.chevronUp)
        XCTAssertEqual(StyleResolution.accordionChevron(isExpanded: false), SystemStrings.StateIcons.chevronDown)
    }

    func testAccordionRotation() {
        XCTAssertEqual(StyleResolution.accordionRotation(isExpanded: true).degrees, 180)
        XCTAssertEqual(StyleResolution.accordionRotation(isExpanded: false).degrees, 0)
    }

    // MARK: - Toast Style

    func testToastStyleIcons() {
        XCTAssertFalse(AppToastStyle.success.icon.isEmpty)
        XCTAssertFalse(AppToastStyle.error.icon.isEmpty)
    }

    func testToastStyleColors() {
        XCTAssertEqual(AppToastStyle.success.color, DesignTokens.Colors.success)
        XCTAssertEqual(AppToastStyle.error.color, DesignTokens.Colors.danger)
    }

    // MARK: - Typography

    func testTypographyTokensExist() {
        XCTAssertNotNil(DesignTokens.Typography.display)
        XCTAssertNotNil(DesignTokens.Typography.largeTitle)
        XCTAssertNotNil(DesignTokens.Typography.body)
        XCTAssertNotNil(DesignTokens.Typography.caption)
    }

    // MARK: - SystemStrings

    func testSystemStringFormatters() {
        XCTAssertEqual(SystemStrings.avatarWithInitials("AB"), "Avatar: AB")
        XCTAssertEqual(SystemStrings.errorPrefix("Fail"), "Error: Fail")
        XCTAssertEqual(SystemStrings.joinedDescription(["A", "B"]), "A. B")
        XCTAssertEqual(SystemStrings.joinedDescription([]), "")
    }

    // MARK: - Bottom Sheet Detent

    func testBottomSheetDetentCases() {
        if case .medium = AppBottomSheetDetent.medium {
            // expected
        } else {
            XCTFail("Should be medium")
        }
        if case .large = AppBottomSheetDetent.large {
            // expected
        } else {
            XCTFail("Should be large")
        }
        if case .custom(300) = AppBottomSheetDetent.custom(300) {
            // expected
        } else {
            XCTFail("Should be custom(300)")
        }
    }
}
