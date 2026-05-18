import SwiftUI

public struct ToggleRow: View {
    let title: String
    let subtitle: String?
    let icon: String?
    @Binding var isOn: Bool
    let tint: Color

    public init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        isOn: Binding<Bool>,
        tint: Color = DesignTokens.Colors.primary
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self._isOn = isOn
        self.tint = tint
    }

    public var body: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: DesignTokens.Sizing.iconMedium))
                    .foregroundColor(tint)
                    .frame(width: DesignTokens.Sizing.iconLarge + DesignTokens.Spacing.xs)
            }

            VStack(alignment: .leading, spacing: 2) {
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
                .tint(tint)
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .padding(.vertical, DesignTokens.Spacing.md)
    }
}
