import SwiftUI

public struct ListItem: View {
    let icon: String?
    let title: String
    let subtitle: String?
    let trailing: String?
    let showChevron: Bool
    let action: (() -> Void)?

    public init(
        icon: String? = nil,
        title: String,
        subtitle: String? = nil,
        trailing: String? = nil,
        showChevron: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing
        self.showChevron = showChevron
        self.action = action
    }

    public var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: DesignTokens.Spacing.md) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: DesignTokens.Sizing.iconMedium))
                        .foregroundColor(DesignTokens.Colors.primary)
                        .frame(width: DesignTokens.Sizing.iconLarge + DesignTokens.Spacing.xs)
                }

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

                if let trailing {
                    Text(trailing)
                        .font(DesignTokens.Typography.subheadline)
                        .foregroundColor(DesignTokens.Colors.textSecondary)
                }

                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: DesignTokens.Sizing.iconSmall, weight: .semibold))
                        .foregroundColor(DesignTokens.Colors.textTertiary)
                }
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .padding(.vertical, DesignTokens.Spacing.md)
        }
        .buttonStyle(.plain)
    }
}
