import SwiftUI

// MARK: - Environment Key
private struct AppThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme.standard
}

// MARK: - Environment Values Extension
extension EnvironmentValues {
    /// Active design-system theme — apply via `.appTheme(_:)` at the app root.
    public var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

// MARK: - View Modifier
/// Applies a design-system theme to a view hierarchy: themed components read
/// it from the environment and native controls follow via `.tint`.
public struct AppThemeModifier: ViewModifier {
    let theme: AppTheme

    public init(theme: AppTheme) {
        self.theme = theme
    }

    public func body(content: Content) -> some View {
        content
            .environment(\.appTheme, theme)
            .environment(\.designAccentColor, theme.accentPrimary)
            .tint(theme.accentPrimary)
    }
}

extension View {
    /// Applies an `AppTheme` to the hierarchy — set once at the app root.
    ///
    /// Prefer the parameterized overload below at app roots: it never names
    /// the `AppTheme` type, so apps keep their own product types named
    /// `AppTheme` (a common product-palette namespace) without collision.
    public func appTheme(_ theme: AppTheme) -> some View {
        modifier(AppThemeModifier(theme: theme))
    }

    /// Applies a theme by describing it — the `AppTheme` type name never
    /// appears in app code, so product-local types named `AppTheme` are
    /// free to coexist with the design system.
    ///
    /// Omitted accents derive from `accentPrimary` (lightened/darkened);
    /// `name` is an arbitrary identifier used by themed component logic.
    public func appTheme(
        name: String,
        accentPrimary: Color,
        accentSecondary: Color? = nil,
        accentTertiary: Color? = nil,
        surface: Color = DesignTokens.Colors.surface,
        radiusStyle: AppRadiusStyle = .standard
    ) -> some View {
        let theme = AppTheme(
            name: name,
            accentPrimary: accentPrimary,
            accentSecondary: accentSecondary ?? accentPrimary.lighten(by: 0.15),
            accentTertiary: accentTertiary ?? accentPrimary.darken(by: 0.15),
            surface: surface,
            radiusStyle: radiusStyle
        )
        return modifier(AppThemeModifier(theme: theme))
    }
}
