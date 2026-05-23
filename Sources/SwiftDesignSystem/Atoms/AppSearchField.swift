import SwiftUI

// MARK: - AppSearchField
public struct AppSearchField: View {
    let placeholder: String
    @Binding var text: String
    var onSubmit: (() -> Void)?

    public init(
        _ placeholder: String = SystemStrings.Defaults.searchPlaceholder,
        text: Binding<String>,
        onSubmit: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.onSubmit = onSubmit
    }

    public var body: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: SystemStrings.StateIcons.search)
                .font(DesignTokens.IconTypography.medium)
                .foregroundColor(DesignTokens.Colors.textTertiary)
                .accessibilityHidden(true)

            TextField(placeholder, text: $text)
                .font(DesignTokens.Typography.body)
                .onSubmit { onSubmit?() }

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: SystemStrings.StateIcons.clearField)
                        .font(DesignTokens.IconTypography.medium)
                        .foregroundColor(DesignTokens.Colors.textTertiary)
                }
                .accessibilityLabel(SystemStrings.Accessibility.clearSearch)
            }
        }
        .frame(height: DesignTokens.Sizing.searchBarHeight + DesignTokens.Spacing.sm)
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous)
                .fill(DesignTokens.Colors.surface)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(placeholder)
    }
}
