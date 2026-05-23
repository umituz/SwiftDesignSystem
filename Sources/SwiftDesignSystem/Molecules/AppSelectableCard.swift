import SwiftUI

// MARK: - AppSelectableCard
public struct AppSelectableCard: View {
    let icon: String
    let title: String
    let subtitle: String?
    @Binding var isSelected: Bool
    let color: Color
    let action: () -> Void

    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        isSelected: Binding<Bool>,
        color: Color = DesignTokens.Colors.primary,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self._isSelected = isSelected
        self.color = color
        self.action = action
    }

    public var body: some View {
        Button(action: {
            AppHaptics.selectionChanged()
            action()
        }) {
            HStack(spacing: DesignTokens.Spacing.md) {
                Image(systemName: icon)
                    .font(DesignTokens.IconTypography.large)
                    .foregroundColor(StyleResolution.selectionForeground(isSelected: isSelected, activeColor: color, inactiveColor: color))
                    .frame(width: DesignTokens.Sizing.badgeMedium, height: DesignTokens.Sizing.badgeMedium)
                    .background(StyleResolution.iconBackground(isSelected: isSelected, activeColor: color))
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))
                    .accessibilityHidden(true)

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

                Spacer()

                Image(systemName: StyleResolution.selectionIndicatorIcon(isSelected: isSelected))
                    .font(DesignTokens.IconTypography.large)
                    .foregroundColor(StyleResolution.iconTintColor(isSelected: isSelected, activeColor: color))
                    .accessibilityHidden(true)
            }
            .padding(DesignTokens.Spacing.lg)
            .background(StyleResolution.selectionBackgroundFill(isSelected: isSelected, activeColor: color))
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous)
                    .stroke(
                        StyleResolution.selectionBorder(isSelected: isSelected, activeColor: color),
                        lineWidth: StyleResolution.selectionBorderWidth(isSelected: isSelected)
                    )
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityValue(StyleResolution.selectionLabel(isSelected: isSelected))
        .accessibilityAddTraits(.isButton)
    }
}
