import SwiftUI

// MARK: - Radius Style
/// Corner-radius personality of a theme. Every themed component scales its
/// base token radius through the active style, so apps sharing the same
/// design system still feel visually distinct.
public enum AppRadiusStyle: Sendable, Equatable {
    /// Crisp, geometric corners.
    case sharp
    /// Default system feel.
    case standard
    /// Friendly, rounded corners.
    case soft

    public var multiplier: CGFloat {
        switch self {
        case .sharp: 0.6
        case .standard: 1.0
        case .soft: 1.4
        }
    }
}

// MARK: - App Theme
/// Brand layer of the design system: accent palette + corner personality.
///
/// Apply once at the app root via `.appTheme(_:)` — themed components read
/// the theme from the environment and native controls follow via `.tint`.
/// Apps use design-system components directly; no wrapper layer is needed.
public struct AppTheme: Sendable, Equatable {
    /// Display name of the preset (also used for diagnostics).
    public let name: String
    /// Primary brand color — buttons, active states, focused controls.
    public let accentPrimary: Color
    /// Supporting accent — second gradient stop, tinted details.
    public let accentSecondary: Color
    /// Highlight accent — third gradient stop, soft fills.
    public let accentTertiary: Color
    /// Text/icon color rendered on top of accent fills (contrast-safe).
    public let onAccent: Color
    /// Corner-radius personality applied to all themed components.
    public let radiusStyle: AppRadiusStyle

    public init(
        name: String,
        accentPrimary: Color,
        accentSecondary: Color,
        accentTertiary: Color,
        onAccent: Color = .white,
        radiusStyle: AppRadiusStyle = .standard
    ) {
        self.name = name
        self.accentPrimary = accentPrimary
        self.accentSecondary = accentSecondary
        self.accentTertiary = accentTertiary
        self.onAccent = onAccent
        self.radiusStyle = radiusStyle
    }

    // MARK: - Derived Styles

    /// Hero gradient used by primary buttons and headers.
    public var heroGradient: LinearGradient {
        LinearGradient(
            colors: [accentPrimary, accentSecondary, accentTertiary],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    /// Soft card gradient for tinted surfaces.
    public var cardGradient: LinearGradient {
        LinearGradient(
            colors: [accentPrimary.opacity(0.1), accentTertiary.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    /// Scales a base token radius by the theme personality.
    public func radius(_ base: CGFloat) -> CGFloat {
        base * radiusStyle.multiplier
    }
}

// MARK: - Built-in Presets
extension AppTheme {

    /// Fleet default — identical to the classic `DesignTokens` palette.
    public static let standard = AppTheme(
        name: "standard",
        accentPrimary: DesignTokens.Colors.primary,
        accentSecondary: DesignTokens.Colors.secondary,
        accentTertiary: DesignTokens.Colors.accent,
        radiusStyle: .standard
    )

    /// Teal/blue — utility and health verticals.
    public static let ocean = AppTheme(
        name: "ocean",
        accentPrimary: Color(red: 0.00, green: 0.55, blue: 0.75),
        accentSecondary: Color(red: 0.10, green: 0.40, blue: 0.85),
        accentTertiary: Color(red: 0.30, green: 0.70, blue: 0.85),
        radiusStyle: .soft
    )

    /// Warm orange/pink — social and entertainment verticals.
    public static let sunset = AppTheme(
        name: "sunset",
        accentPrimary: Color(red: 0.95, green: 0.45, blue: 0.25),
        accentSecondary: Color(red: 0.85, green: 0.30, blue: 0.55),
        accentTertiary: Color(red: 0.98, green: 0.60, blue: 0.35),
        radiusStyle: .standard
    )

    /// Calm greens — wellness and outdoor verticals.
    public static let forest = AppTheme(
        name: "forest",
        accentPrimary: Color(red: 0.13, green: 0.55, blue: 0.35),
        accentSecondary: Color(red: 0.20, green: 0.65, blue: 0.45),
        accentTertiary: Color(red: 0.35, green: 0.70, blue: 0.40),
        radiusStyle: .standard
    )

    /// Deep purple/blue — premium, knowledge verticals.
    public static let royal = AppTheme(
        name: "royal",
        accentPrimary: Color(red: 0.35, green: 0.25, blue: 0.80),
        accentSecondary: Color(red: 0.45, green: 0.30, blue: 0.70),
        accentTertiary: Color(red: 0.55, green: 0.40, blue: 0.90),
        radiusStyle: .soft
    )

    /// Pink/red — lifestyle and relationship verticals.
    public static let rose = AppTheme(
        name: "rose",
        accentPrimary: Color(red: 0.88, green: 0.30, blue: 0.50),
        accentSecondary: Color(red: 0.80, green: 0.25, blue: 0.65),
        accentTertiary: Color(red: 0.95, green: 0.45, blue: 0.55),
        radiusStyle: .standard
    )

    /// Warm amber with contrast-safe dark labels — productivity verticals.
    public static let amber = AppTheme(
        name: "amber",
        accentPrimary: Color(red: 0.95, green: 0.65, blue: 0.15),
        accentSecondary: Color(red: 0.98, green: 0.55, blue: 0.25),
        accentTertiary: Color(red: 1.00, green: 0.72, blue: 0.30),
        onAccent: Color(red: 0.15, green: 0.12, blue: 0.05),
        radiusStyle: .sharp
    )

    /// Navy/cyan — developer and data verticals.
    public static let midnight = AppTheme(
        name: "midnight",
        accentPrimary: Color(red: 0.15, green: 0.25, blue: 0.55),
        accentSecondary: Color(red: 0.10, green: 0.45, blue: 0.60),
        accentTertiary: Color(red: 0.20, green: 0.60, blue: 0.75),
        radiusStyle: .soft
    )
}
