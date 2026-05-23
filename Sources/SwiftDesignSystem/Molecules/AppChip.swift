import SwiftUI

// MARK: - AppChip
public struct AppChip: View {
    let title: String
    let icon: String?
    @Binding var isSelected: Bool
    let color: Color
    let action: () -> Void

    public init(
        _ title: String,
        icon: String? = nil,
        isSelected: Binding<Bool>,
        color: Color = DesignTokens.Colors.primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self._isSelected = isSelected
        self.color = color
        self.action = action
    }

    public var body: some View {
        Button(action: {
            AppHaptics.selectionChanged()
            action()
        }) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                if let icon {
                    Image(systemName: icon)
                        .font(DesignTokens.IconTypography.small)
                }
                Text(title)
                    .font(DesignTokens.Typography.subheadline)
            }
            .padding(.horizontal, DesignTokens.Spacing.md)
            .padding(.vertical, DesignTokens.Spacing.sm)
            .background(StyleResolution.selectionBackground(isSelected: isSelected, activeColor: color))
            .foregroundColor(StyleResolution.selectionForeground(isSelected: isSelected, activeColor: color))
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(StyleResolution.selectionBorder(isSelected: isSelected, activeColor: color, inactiveColor: Color.clear), lineWidth: DesignTokens.Border.regular)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(StyleResolution.selectionLabel(isSelected: isSelected))
    }
}
