import SwiftUI

// MARK: - SectionHeader
public struct SectionHeader: View {
    let title: String
    let actionTitle: String?
    let action: (() -> Void)?

    public init(
        title: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        HStack {
            Text(title)
                .font(DesignTokens.Typography.headline)
                .foregroundColor(DesignTokens.Colors.textPrimary)

            Spacer()

            if let actionTitle, let action {
                Button(action: {
                    AppHaptics.light()
                    action()
                }) {
                    Text(actionTitle)
                        .font(DesignTokens.Typography.subheadlineBold)
                        .foregroundColor(DesignTokens.Colors.primary)
                }
                .accessibilityLabel(actionTitle)
                .accessibilityAddTraits(.isButton)
            }
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }
}
