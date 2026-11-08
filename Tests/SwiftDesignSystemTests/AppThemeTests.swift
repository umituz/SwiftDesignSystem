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
}

// MARK: - Preset Catalog
extension AppTheme {
    /// All built-in presets, for tests and tooling.
    static let allPresets: [AppTheme] = [
        .standard, .ocean, .sunset, .forest, .royal, .rose, .amber, .midnight
    ]
}
