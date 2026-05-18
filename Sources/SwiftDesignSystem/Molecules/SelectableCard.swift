import SwiftUI

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
        Button(action: action) {
            HStack(spacing: DesignTokens.Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: DesignTokens.Sizing.iconLarge))
                    .foregroundColor(isSelected ? .white : color)
                    .frame(width: DesignTokens.Sizing.badgeMedium, height: DesignTokens.Sizing.badgeMedium)
                    .background(isSelected ? color : color.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))

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
            }
            .padding(DesignTokens.Spacing.lg)
            .background(isSelected ? color.opacity(0.06) : DesignTokens.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous)
                    .stroke(isSelected ? color : DesignTokens.Colors.separator, lineWidth: isSelected ? DesignTokens.Border.thick : DesignTokens.Border.thin)
            )
        }
        .buttonStyle(.plain)
    }
}
