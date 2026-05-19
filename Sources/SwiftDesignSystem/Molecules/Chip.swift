import SwiftUI

// MARK: - Chip
public struct Chip: View {
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
                        .font(.system(size: DesignTokens.Sizing.iconSmall))
                }
                Text(title)
                    .font(DesignTokens.Typography.subheadline)
            }
            .padding(.horizontal, DesignTokens.Spacing.md)
            .padding(.vertical, DesignTokens.Spacing.sm)
            .background(isSelected ? color : Color.clear)
            .foregroundColor(isSelected ? DesignTokens.Colors.textOnPrimary : DesignTokens.Colors.textPrimary)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.clear : DesignTokens.Colors.separator, lineWidth: DesignTokens.Border.regular)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
    }
}
