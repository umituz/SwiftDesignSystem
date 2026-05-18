import SwiftUI

public enum StatCardStyle {
    case compact
    case standard
    case large
    case gradient
}

public struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let style: StatCardStyle
    let color: Color

    public init(
        icon: String,
        value: String,
        label: String,
        style: StatCardStyle = .standard,
        color: Color = DesignTokens.Colors.primary
    ) {
        self.icon = icon
        self.value = value
        self.label = label
        self.style = style
        self.color = color
    }

    public var body: some View {
        switch style {
        case .compact:
            compactContent
        case .standard:
            standardContent
        case .large:
            largeContent
        case .gradient:
            gradientContent
        }
    }

    private var compactContent: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconMedium))
                .foregroundColor(color)

            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(DesignTokens.Typography.headline)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
                Text(label)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
            }
        }
    }

    private var standardContent: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconLarge))
                .foregroundColor(color)

            Text(value)
                .font(DesignTokens.Typography.title3)
                .foregroundColor(DesignTokens.Colors.textPrimary)

            Text(label)
                .font(DesignTokens.Typography.caption)
                .foregroundColor(DesignTokens.Colors.textTertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(DesignTokens.Spacing.lg)
        .background(DesignTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
        .shadow(color: DesignShadow(color: .black.opacity(0.06), radius: 4, y: 2).color, radius: 4, y: 2)
    }

    private var largeContent: some View {
        VStack(spacing: DesignTokens.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconXLarge))
                .foregroundColor(color)

            Text(value)
                .font(DesignTokens.Typography.largeTitle)
                .foregroundColor(DesignTokens.Colors.textPrimary)

            Text(label)
                .font(DesignTokens.Typography.subheadline)
                .foregroundColor(DesignTokens.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(DesignTokens.Spacing.xl)
        .background(DesignTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.xl, style: .continuous))
        .shadow(color: DesignShadow(color: .black.opacity(0.1), radius: 8, y: 4).color, radius: 8, y: 4)
    }

    private var gradientContent: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconLarge))
                .foregroundColor(.white)

            Text(value)
                .font(DesignTokens.Typography.title3)
                .foregroundColor(.white)

            Text(label)
                .font(DesignTokens.Typography.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(DesignTokens.Spacing.lg)
        .background(
            LinearGradient(
                colors: [color, color.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
        .shadow(color: color.opacity(0.3), radius: 10, y: 5)
    }
}
