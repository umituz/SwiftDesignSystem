import SwiftUI

// MARK: - SettingItem
public struct SettingItem: View {
    let icon: String
    let title: String
    let subtitle: String?
    let color: Color

    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        color: Color = DesignTokens.Colors.primary
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.color = color
    }

    public var body: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconMedium))
                .foregroundColor(DesignTokens.Colors.textOnPrimary)
                .frame(width: DesignTokens.Sizing.badgeSmall, height: DesignTokens.Sizing.badgeSmall)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.sm, style: .continuous))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(DesignTokens.Typography.body)
                    .foregroundColor(DesignTokens.Colors.textPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(DesignTokens.Typography.caption)
                        .foregroundColor(DesignTokens.Colors.textTertiary)
                }
            }

            Spacer()
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .padding(.vertical, DesignTokens.Spacing.md)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
    }
}
