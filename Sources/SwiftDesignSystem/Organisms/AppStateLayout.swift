import SwiftUI

// MARK: - State Layout
struct AppStateLayout: View {
    let icon: String
    let iconColor: Color
    let title: String
    let message: String?
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    let accessibilityLabel: String

    init(
        icon: String,
        iconColor: Color,
        title: String,
        message: String? = nil,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil,
        accessibilityLabel: String? = nil
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        var parts = [title]
        if let message { parts.append(message) }
        self.accessibilityLabel = accessibilityLabel ?? SystemStrings.joinedDescription(parts)
    }

    var body: some View {
        VStack(spacing: DesignTokens.Spacing.xl) {
            Image(systemName: icon)
                .font(DesignTokens.IconTypography.hero)
                .foregroundColor(iconColor)
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

            if let buttonTitle, let buttonAction {
                AppButton(buttonTitle, action: buttonAction)
                    .padding(.horizontal, DesignTokens.Spacing.huge)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(DesignTokens.Spacing.xxxl)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
    }
}
