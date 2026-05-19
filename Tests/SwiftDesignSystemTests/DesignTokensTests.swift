import XCTest
@testable import SwiftDesignSystem
import SwiftUI

final class DesignTokensTests: XCTestCase {

    // MARK: - Spacing Tests
    func testSpacingValues() {
        XCTAssertEqual(DesignTokens.Spacing.xs, 4)
        XCTAssertEqual(DesignTokens.Spacing.sm, 8)
        XCTAssertEqual(DesignTokens.Spacing.md, 12)
        XCTAssertEqual(DesignTokens.Spacing.lg, 16)
        XCTAssertEqual(DesignTokens.Spacing.xl, 20)
        XCTAssertEqual(DesignTokens.Spacing.xxl, 24)
        XCTAssertEqual(DesignTokens.Spacing.xxxl, 32)
        XCTAssertEqual(DesignTokens.Spacing.huge, 48)
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

    // MARK: - Shadow Tests
    func testShadowEquality() {
        let shadow1 = DesignShadow(color: .black, radius: 4, y: 2)
        let shadow2 = DesignShadow(color: .black, radius: 4, y: 2)
        XCTAssertEqual(shadow1, shadow2)
    }

    func testPredefinedShadows() {
        XCTAssertEqual(DesignTokens.Shadows.subtle.radius, 4)
        XCTAssertEqual(DesignTokens.Shadows.medium.radius, 8)
        XCTAssertEqual(DesignTokens.Shadows.strong.radius, 16)
        XCTAssertEqual(DesignTokens.Shadows.cardTint.radius, 10)
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
}
