import SwiftUI

// MARK: - SelectableCard
public struct SelectableCard: View {
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
                    .font(.system(size: DesignTokens.Sizing.iconLarge))
                    .foregroundColor(isSelected ? DesignTokens.Colors.textOnPrimary : color)
                    .frame(width: DesignTokens.Sizing.badgeMedium, height: DesignTokens.Sizing.badgeMedium)
                    .background(isSelected ? color : color.opacity(DesignTokens.Opacity.veryTransparent))
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 2) {
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

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: DesignTokens.Sizing.iconLarge))
                    .foregroundColor(isSelected ? color : DesignTokens.Colors.textTertiary)
                    .accessibilityHidden(true)
            }
            .padding(DesignTokens.Spacing.lg)
            .background(isSelected ? color.opacity(DesignTokens.Opacity.nearlyInvisible) : DesignTokens.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous)
                    .stroke(isSelected ? color : DesignTokens.Colors.separator, lineWidth: isSelected ? DesignTokens.Border.thick : DesignTokens.Border.thin)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
        .accessibilityAddTraits(.isButton)
    }
}
