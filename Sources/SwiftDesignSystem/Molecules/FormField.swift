import SwiftUI

public struct FormField<Content: View>: View {
    let label: String
    let errorMessage: String?
    @ViewBuilder let content: () -> Content

    public init(
        label: String,
        errorMessage: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.label = label
        self.errorMessage = errorMessage
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            Text(label)
                .font(DesignTokens.Typography.footnote)
                .foregroundColor(DesignTokens.Colors.textSecondary)

            content()

            if let errorMessage {
                Text(errorMessage)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.danger)
            }
        }
    }
}
