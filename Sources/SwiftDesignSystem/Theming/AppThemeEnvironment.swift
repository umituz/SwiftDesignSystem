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
            .tint(theme.accentPrimary)
    }
}

extension View {
    /// Applies an `AppTheme` to the hierarchy — set once at the app root.
    public func appTheme(_ theme: AppTheme) -> some View {
        modifier(AppThemeModifier(theme: theme))
    }
}
