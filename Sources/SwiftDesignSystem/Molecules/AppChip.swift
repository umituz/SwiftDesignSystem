import SwiftUI

// MARK: - AppChip
public struct AppChip: View {
    let title: String
    let icon: String?
    @Binding var isSelected: Bool
    let explicitColor: Color?
    let action: () -> Void

    @Environment(\.designAccentColor) private var accentColor

    public init(
        _ title: String,
        icon: String? = nil,
        isSelected: Binding<Bool>,
        color: Color? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
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
            chipContent
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(StyleResolution.selectionLabel(isSelected: isSelected))
    }

    private var chipContent: some View {
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
        .background(chipBackground)
        .foregroundColor(chipForeground)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(chipBorder, lineWidth: DesignTokens.Border.regular))
    }

    private var chipBackground: Color {
        StyleResolution.selectionBackground(isSelected: isSelected, activeColor: resolvedColor)
    }

    private var chipForeground: Color {
        StyleResolution.selectionForeground(isSelected: isSelected, activeColor: resolvedColor)
    }

    private var chipBorder: Color {
        StyleResolution.selectionBorder(
            isSelected: isSelected,
            activeColor: resolvedColor,
            inactiveColor: Color.clear
        )
    }
}
