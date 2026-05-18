import SwiftUI

// MARK: - Design Environment Key
private struct DesignAccentColorKey: EnvironmentKey {
    static let defaultValue = DesignTokens.Colors.primary
}

private struct DesignCornerRadiusKey: EnvironmentKey {
    static let defaultValue = DesignTokens.CornerRadius.lg
}

// MARK: - Environment Values Extension
extension EnvironmentValues {
    public var designAccentColor: Color {
        get { self[DesignAccentColorKey.self] }
        set { self[DesignAccentColorKey.self] = newValue }
    }

    public var designCornerRadius: CGFloat {
        get { self[DesignCornerRadiusKey.self] }
        set { self[DesignCornerRadiusKey.self] = newValue }
    }
}

// MARK: - View Modifier for Theme Override
public struct DesignAccentModifier: ViewModifier {
    let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content.environment(\.designAccentColor, color)
    }
}

extension View {
    public func designAccentColor(_ color: Color) -> some View {
        modifier(DesignAccentModifier(color: color))
    }
}
