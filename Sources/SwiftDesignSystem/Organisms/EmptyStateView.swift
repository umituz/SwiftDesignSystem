import SwiftUI

public struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String?
    let buttonTitle: String?
    let buttonAction: (() -> Void)?

    public init(
        icon: String = "tray",
        title: String,
        message: String? = nil,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }

    public var body: some View {
        VStack(spacing: DesignTokens.Spacing.xl) {
            Image(systemName: icon)
                .font(.system(size: DesignTokens.Sizing.iconHero))
                .foregroundColor(DesignTokens.Colors.textTertiary)

            VStack(spacing: DesignTokens.Spacing.xs) {
                Text(title)
                    .font(DesignTokens.Typography.title3)
                    .foregroundColor(DesignTokens.Colors.textPrimary)

                if let message {
                    Text(message)
                        .font(DesignTokens.Typography.subheadline)
                        .foregroundColor(DesignTokens.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                }
            }

            if let buttonTitle, let buttonAction {
                AppButton(buttonTitle, action: buttonAction)
                    .padding(.horizontal, DesignTokens.Spacing.huge)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(DesignTokens.Spacing.xxxl)
    }
}
