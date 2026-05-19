import SwiftUI

// MARK: - Stat Card Style
public enum StatCardStyle {
    case compact
    case standard
    case large
    case gradient
}

// MARK: - StatCard
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

    // MARK: - Compact

    private var compactContent: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconMedium))
                .foregroundColor(color)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(DesignTokens.Typography.headline)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
                Text(label)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }

    // MARK: - Standard

    private var standardContent: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconLarge))
                .foregroundColor(color)
                .accessibilityHidden(true)

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
        .appShadow(DesignTokens.Shadows.subtle)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }

    // MARK: - Large

    private var largeContent: some View {
        VStack(spacing: DesignTokens.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconXLarge))
                .foregroundColor(color)
                .accessibilityHidden(true)

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
        .appShadow(DesignTokens.Shadows.medium)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }

    // MARK: - Gradient

    private var gradientContent: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconLarge))
                .foregroundColor(DesignTokens.Colors.textOnPrimary)
                .accessibilityHidden(true)

            Text(value)
                .font(DesignTokens.Typography.title3)
                .foregroundColor(DesignTokens.Colors.textOnPrimary)

            Text(label)
                .font(DesignTokens.Typography.caption)
                .foregroundColor(DesignTokens.Colors.textOnPrimary.opacity(DesignTokens.Opacity.textOnTint))
        }
        .frame(maxWidth: .infinity)
        .padding(DesignTokens.Spacing.lg)
        .background(
            LinearGradient(
                colors: [color, color.opacity(DesignTokens.Opacity.semiTransparent)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
        .appShadow(DesignTokens.Shadows.cardTint)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }
}
