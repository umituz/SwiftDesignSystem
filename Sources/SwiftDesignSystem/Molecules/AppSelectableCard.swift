import SwiftUI

// MARK: - AppSelectableCard
public struct AppSelectableCard: View {
    let icon: String
    let title: String
    let subtitle: String?
    @Binding var isSelected: Bool
    let explicitColor: Color?
    let action: () -> Void

    @Environment(\.designAccentColor) private var accentColor

    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        isSelected: Binding<Bool>,
        color: Color? = nil,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self._isSelected = isSelected
        self.explicitColor = color
        self.action = action
    }

    private var resolvedColor: Color {
        explicitColor ?? accentColor
    }

    public var body: some View {
        Button {
            AppHaptics.selectionChanged()
            action()
        } label: {
            cardContent
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityValue(StyleResolution.selectionLabel(isSelected: isSelected))
        .accessibilityAddTraits(.isButton)
    }

    private var cardContent: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            iconView
            titleContent
            Spacer()
            selectionIndicator
        }
        .padding(DesignTokens.Spacing.lg)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
        .overlay(cardBorder)
    }

    private var iconView: some View {
        Image(systemName: icon)
            .font(DesignTokens.IconTypography.large)
            .foregroundColor(iconForeground)
            .frame(width: DesignTokens.Sizing.badgeMedium, height: DesignTokens.Sizing.badgeMedium)
            .background(iconBg)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))
            .accessibilityHidden(true)
    }

    private var iconForeground: Color {
        StyleResolution.selectionForeground(
            isSelected: isSelected,
            activeColor: resolvedColor,
            inactiveColor: resolvedColor
        )
    }

    private var iconBg: Color {
        StyleResolution.iconBackground(isSelected: isSelected, activeColor: resolvedColor)
    }

    private var titleContent: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.tight) {
            Text(title)
                .font(DesignTokens.Typography.bodyBold)
                .foregroundColor(DesignTokens.Colors.textPrimary)

            if let subtitle {
                Text(subtitle)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
            }
        }
    }

    private var selectionIndicator: some View {
        Image(systemName: StyleResolution.selectionIndicatorIcon(isSelected: isSelected))
            .font(DesignTokens.IconTypography.large)
            .foregroundColor(StyleResolution.iconTintColor(isSelected: isSelected, activeColor: resolvedColor))
            .accessibilityHidden(true)
    }

    private var cardBackground: Color {
        StyleResolution.selectionBackgroundFill(isSelected: isSelected, activeColor: resolvedColor)
    }

    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous)
            .stroke(
                StyleResolution.selectionBorder(isSelected: isSelected, activeColor: resolvedColor),
                lineWidth: StyleResolution.selectionBorderWidth(isSelected: isSelected)
            )
    }
}
