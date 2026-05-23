import SwiftUI

// MARK: - AppToggle
public struct AppToggle: View {
    let label: String
    @Binding var isOn: Bool
    let tint: Color
    let isDisabled: Bool

    public init(
        label: String,
        isOn: Binding<Bool>,
        tint: Color = DesignTokens.Colors.primary,
        isDisabled: Bool = false
    ) {
        self.label = label
        self._isOn = isOn
        self.tint = tint
        self.isDisabled = isDisabled
    }

    public var body: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            Text(label)
                .font(DesignTokens.Typography.body)
                .foregroundColor(DesignTokens.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(tint)
                .onChange(of: isOn) { _, _ in
                    AppHaptics.selectionChanged()
                }
        }
        .opacity(StyleResolution.disabledOpacity(isDisabled: isDisabled))
        .disabled(isDisabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityValue(StyleResolution.toggleLabel(isOn: isOn))
        .accessibilityAddTraits(.isToggle)
    }
}
