import SwiftUI

// MARK: - ErrorStateView
public struct ErrorStateView: View {
    let icon: String
    let title: String
    let message: String?
    let buttonTitle: String
    let buttonAction: () -> Void

    public init(
        icon: String = "exclamationmark.triangle",
        title: String,
        message: String? = nil,
        buttonTitle: String = "Try Again",
        buttonAction: @escaping () -> Void
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
                .foregroundColor(DesignTokens.Colors.danger)
                .accessibilityHidden(true)

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

            AppButton(buttonTitle, action: buttonAction)
                .padding(.horizontal, DesignTokens.Spacing.huge)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(DesignTokens.Spacing.xxxl)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }

    private var accessibilityDescription: String {
        var parts = ["Error: \(title)"]
        if let message { parts.append(message) }
        return parts.joined(separator: ". ")
    }
}
