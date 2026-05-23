import SwiftUI

// MARK: - Icon Size
public enum AppIconSize {
    case small
    case medium
    case large
    case xLarge
    case hero

    var font: Font {
        switch self {
        case .small: return DesignTokens.IconTypography.small
        case .medium: return DesignTokens.IconTypography.medium
        case .large: return DesignTokens.IconTypography.large
        case .xLarge: return DesignTokens.IconTypography.xLarge
        case .hero: return DesignTokens.IconTypography.hero
        }
    }
}

// MARK: - AppIcon
public struct AppIcon: View {
    let name: String
    let size: AppIconSize
    let color: Color
    let renderingMode: SymbolRenderingMode

    public init(
        _ name: String,
        size: AppIconSize = .medium,
        color: Color = DesignTokens.Colors.textTertiary,
        renderingMode: SymbolRenderingMode = .monochrome
    ) {
        self.name = name
        self.size = size
        self.color = color
        self.renderingMode = renderingMode
    }

    public var body: some View {
        Image(systemName: name)
            .font(size.font)
            .symbolRenderingMode(renderingMode)
            .foregroundColor(color)
            .accessibilityHidden(true)
    }
}
