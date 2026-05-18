import SwiftUI

public struct InfoCard: View {
    let title: String
    let message: String?
    let icon: String?
    let buttonTitle: String?
    let buttonAction: (() -> Void)?

    public init(
        title: String,
        message: String? = nil,
        icon: String? = nil,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.icon = icon
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.md) {
            HStack(spacing: DesignTokens.Spacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: DesignTokens.Sizing.iconLarge))
                        .foregroundColor(DesignTokens.Colors.primary)
                }

                Text(title)
                    .font(DesignTokens.Typography.headline)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
            }

            if let message {
                Text(message)
                    .font(DesignTokens.Typography.subheadline)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let buttonTitle, let buttonAction {
                AppButton(buttonTitle, style: .secondary, action: buttonAction)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(DesignTokens.Spacing.lg)
        .background(DesignTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
    }
}
