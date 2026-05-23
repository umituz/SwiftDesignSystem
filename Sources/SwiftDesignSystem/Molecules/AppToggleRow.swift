import SwiftUI

// MARK: - ToggleRow
public struct AppToggleRow: View {
    let title: String
    let subtitle: String?
    let icon: String?
    @Binding var isOn: Bool
    let explicitTint: Color?

    @Environment(\.designAccentColor) private var accentColor

    public init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        isOn: Binding<Bool>,
        tint: Color? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self._isOn = isOn
        self.explicitTint = tint
    }

    private var resolvedTint: Color {
        explicitTint ?? accentColor
    }

    public var body: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            if let icon {
                Image(systemName: icon)
                    .font(DesignTokens.IconTypography.medium)
                    .foregroundColor(resolvedTint)
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

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(resolvedTint)
                .onChange(of: isOn) { _, _ in
                    AppHaptics.selectionChanged()
                }
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .padding(.vertical, DesignTokens.Spacing.md)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityValue(StyleResolution.toggleLabel(isOn: isOn))
    }
}
