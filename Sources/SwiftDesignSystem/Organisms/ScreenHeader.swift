import SwiftUI

public struct ScreenHeader: View {
    let title: String
    let subtitle: String?
    let leftIcon: String?
    let rightIcon: String?
    let leftAction: (() -> Void)?
    let rightAction: (() -> Void)?

    public init(
        title: String,
        subtitle: String? = nil,
        leftIcon: String? = nil,
        rightIcon: String? = nil,
        leftAction: (() -> Void)? = nil,
        rightAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.leftAction = leftAction
        self.rightAction = rightAction
    }

    public var body: some View {
        HStack(alignment: .center) {
            if let leftIcon, let leftAction {
                Button(action: leftAction) {
                    Image(systemName: leftIcon)
                        .font(.system(size: DesignTokens.Sizing.iconLarge))
                        .foregroundColor(DesignTokens.Colors.textPrimary)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(DesignTokens.Typography.largeTitle)
                    .foregroundColor(DesignTokens.Colors.textPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(DesignTokens.Typography.subheadline)
                        .foregroundColor(DesignTokens.Colors.textSecondary)
                }
            }

            Spacer()

            if let rightIcon, let rightAction {
                Button(action: rightAction) {
                    Image(systemName: rightIcon)
                        .font(.system(size: DesignTokens.Sizing.iconLarge))
                        .foregroundColor(DesignTokens.Colors.textPrimary)
                }
            }
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .padding(.vertical, DesignTokens.Spacing.sm)
    }
}
