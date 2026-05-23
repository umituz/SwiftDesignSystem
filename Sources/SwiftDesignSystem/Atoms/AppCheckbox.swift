import SwiftUI

// MARK: - Checkbox Shape
public enum AppCheckboxStyle {
    case `default`
    case circular
}

// MARK: - AppCheckbox
public struct AppCheckbox: View {
    let label: String
    @Binding var isChecked: Bool
    let color: Color
    let style: AppCheckboxStyle
    let isDisabled: Bool

    public init(
        label: String,
        isChecked: Binding<Bool>,
        color: Color = DesignTokens.Colors.primary,
        style: AppCheckboxStyle = .default,
        isDisabled: Bool = false
    ) {
        self.label = label
        self._isChecked = isChecked
        self.color = color
        self.style = style
        self.isDisabled = isDisabled
    }

    public var body: some View {
        Button {
            AppHaptics.selectionChanged()
            isChecked.toggle()
        } label: {
            HStack(spacing: DesignTokens.Spacing.sm) {
                checkboxIndicator

                Text(label)
                    .font(DesignTokens.Typography.body)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
            }
        }
        .buttonStyle(.plain)
        .opacity(StyleResolution.disabledOpacity(isDisabled: isDisabled))
        .disabled(isDisabled)
        .accessibilityLabel(label)
        .accessibilityValue(StyleResolution.checkboxLabel(isChecked: isChecked))
        .accessibilityAddTraits(.isButton)
    }

    @ViewBuilder
    private var checkboxIndicator: some View {
        if style == .circular {
            circularIndicator
        } else {
            defaultIndicator
        }
    }

    private var defaultIndicator: some View {
        Image(systemName: StyleResolution.checkboxIcon(isChecked: isChecked))
            .font(DesignTokens.IconTypography.medium)
            .foregroundColor(StyleResolution.selectionForeground(
                isSelected: isChecked,
                activeColor: color,
                inactiveColor: DesignTokens.Colors.textTertiary
            ))
            .frame(width: DesignTokens.Sizing.checkboxSize, height: DesignTokens.Sizing.checkboxSize)
    }

    private var circularIndicator: some View {
        ZStack {
            Circle()
                .fill(StyleResolution.selectionBackground(isSelected: isChecked, activeColor: color))
                .frame(width: DesignTokens.Sizing.checkboxSize, height: DesignTokens.Sizing.checkboxSize)

            Circle()
                .stroke(
                    StyleResolution.selectionBorder(isSelected: isChecked, activeColor: color),
                    lineWidth: StyleResolution.selectionBorderWidth(isSelected: isChecked)
                )
                .frame(width: DesignTokens.Sizing.checkboxSize, height: DesignTokens.Sizing.checkboxSize)

            Image(systemName: SystemStrings.StateIcons.selectedIndicator)
                .font(DesignTokens.IconTypography.small)
                .foregroundColor(StyleResolution.selectionForeground(
                    isSelected: isChecked,
                    activeColor: DesignTokens.Colors.textOnPrimary,
                    inactiveColor: Color.clear
                ))
        }
    }
}
