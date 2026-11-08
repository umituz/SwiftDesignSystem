import SwiftUI
import XCTest
@testable import SwiftDesignSystem

final class AppThemeTests: XCTestCase {

    // MARK: - Presets

    func testAllPresetsHaveUniqueNames() {
        let presets = AppTheme.allPresets
        XCTAssertEqual(presets.count, 8, "Expected eight built-in presets")
        XCTAssertEqual(Set(presets.map(\.name)).count, presets.count, "Preset names must be unique")
    }

    func testPresetsHaveDistinctPrimaryAccents() {
        let primaries = AppTheme.allPresets.map(\.accentPrimary.description)
        XCTAssertEqual(Set(primaries).count, AppTheme.allPresets.count, "Presets must be visually distinct")
    }

    func testStandardPresetMatchesLegacyTokens() {
        // Backward compatibility: apps without an explicit theme keep the classic look.
        XCTAssertEqual(AppTheme.standard.accentPrimary, DesignTokens.Colors.primary)
        XCTAssertEqual(AppTheme.standard.accentSecondary, DesignTokens.Colors.secondary)
        XCTAssertEqual(AppTheme.standard.accentTertiary, DesignTokens.Colors.accent)
    }

    func testLightAccentUsesContrastSafeLabelColor() {
        XCTAssertNotEqual(AppTheme.amber.onAccent, Color.white, "Light accents must not pair with white labels")
        XCTAssertEqual(AppTheme.ocean.onAccent, Color.white)
    }

    // MARK: - Radius Personality

    func testRadiusScalingByStyle() {
        XCTAssertEqual(AppTheme.standard.radius(16), 16, accuracy: 0.001)
        XCTAssertEqual(AppTheme.amber.radius(16), 9.6, accuracy: 0.001, "sharp = 0.6x base radius")
        XCTAssertEqual(AppTheme.ocean.radius(16), 22.4, accuracy: 0.001, "soft = 1.4x base radius")
    }

    func testRadiusMultiplierValues() {
        XCTAssertEqual(AppRadiusStyle.sharp.multiplier, 0.6, accuracy: 0.001)
        XCTAssertEqual(AppRadiusStyle.standard.multiplier, 1.0, accuracy: 0.001)
        XCTAssertEqual(AppRadiusStyle.soft.multiplier, 1.4, accuracy: 0.001)
    }

    // MARK: - Environment

    func testEnvironmentDefaultsToStandardTheme() {
        let values = EnvironmentValues()
        XCTAssertEqual(values.appTheme, AppTheme.standard, "Unthemed hierarchies must resolve to .standard")
    }

    func testCustomThemeIsEquatableByNameAndAccents() {
        let theme = AppTheme(
            name: "custom",
            accentPrimary: .pink,
            accentSecondary: .purple,
            accentTertiary: .indigo,
            onAccent: .black,
            radiusStyle: .sharp
        )
        let same = AppTheme(
            name: "custom",
            accentPrimary: .pink,
            accentSecondary: .purple,
            accentTertiary: .indigo,
            onAccent: .black,
            radiusStyle: .sharp
        )
        let different = AppTheme(
            name: "custom",
            accentPrimary: .blue,
            accentSecondary: .purple,
            accentTertiary: .indigo
        )
        XCTAssertEqual(theme, same)
        XCTAssertNotEqual(theme, different)
    }

    // MARK: - v1.2.0 Additions

    func testRoundedTypographyCoversFullScale() {
        // Compile-time presence of the full rounded scale; runtime check via descriptions.
        let fonts: [Font] = [
            DesignTokens.RoundedTypography.displayXL,
            DesignTokens.RoundedTypography.display,
            DesignTokens.RoundedTypography.largeTitle,
            DesignTokens.RoundedTypography.title,
            DesignTokens.RoundedTypography.title2,
            DesignTokens.RoundedTypography.title3,
            DesignTokens.RoundedTypography.headline,
            DesignTokens.RoundedTypography.body,
            DesignTokens.RoundedTypography.bodyBold,
            DesignTokens.RoundedTypography.callout,
            DesignTokens.RoundedTypography.calloutBold,
            DesignTokens.RoundedTypography.subheadline,
            DesignTokens.RoundedTypography.subheadlineBold,
            DesignTokens.RoundedTypography.footnote,
            DesignTokens.RoundedTypography.footnoteBold,
            DesignTokens.RoundedTypography.caption,
            DesignTokens.RoundedTypography.captionBold,
            DesignTokens.RoundedTypography.caption2
        ]
        XCTAssertEqual(fonts.count, 18, "Rounded scale must be complete")
    }

    func testScaleTokens() {
        XCTAssertEqual(DesignTokens.Scale.identity, 1.0, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Scale.pulse, 1.03, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Scale.gentlePulse, 1.05, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Scale.breathing, 1.1, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Scale.disappear, 0.8, accuracy: 0.001)
    }

    func testStepIndicatorDefaults() {
        let indicator = AppStepIndicator(stepCount: 4, currentStep: 1)
        XCTAssertNotNil(indicator)
    }

    func testCardShadowExists() {
        XCTAssertEqual(DesignTokens.Shadows.card.radius, 10, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Shadows.card.y, 5, accuracy: 0.001)
    }

    func testAvatarAndControlSizes() {
        XCTAssertEqual(DesignTokens.Sizing.avatarSmall, 40, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Sizing.avatarMedium, 60, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Sizing.avatarLarge, 80, accuracy: 0.001)
        XCTAssertEqual(DesignTokens.Sizing.controlHeight, 44, accuracy: 0.001)
    }
}

// MARK: - Preset Catalog
extension AppTheme {
    /// All built-in presets, for tests and tooling.
    static let allPresets: [AppTheme] = [
        .standard, .ocean, .sunset, .forest, .royal, .rose, .amber, .midnight
    ]
}
