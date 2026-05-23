import SwiftUI

// MARK: - ListItem
public struct AppListItem: View {
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
        Button(action: {
            AppHaptics.light()
            action?()
        }) {
            HStack(spacing: DesignTokens.Spacing.md) {
                if let icon {
                    Image(systemName: icon)
                        .font(DesignTokens.IconTypography.medium)
                        .foregroundColor(DesignTokens.Colors.primary)
                        .frame(width: DesignTokens.Sizing.iconLarge + DesignTokens.Spacing.xs)
                        .accessibilityHidden(true)
                }

                VStack(alignment: .leading, spacing: DesignTokens.Spacing.tight) {
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
                    Image(systemName: SystemStrings.StateIcons.forwardNavigation)
                        .font(DesignTokens.IconTypography.chevron)
                        .foregroundColor(DesignTokens.Colors.textTertiary)
                        .accessibilityHidden(true)
                }
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .padding(.vertical, DesignTokens.Spacing.md)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
        .accessibilityAddTraits(action != nil ? .isButton : [])
    }

    private var accessibilityDescription: String {
        var parts = [title]
        if let subtitle { parts.append(subtitle) }
        if let trailing { parts.append(trailing) }
        return parts.joined(separator: ", ")
    }
}
