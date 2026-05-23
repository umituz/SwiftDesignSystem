import SwiftUI

// MARK: - ScreenHeader
public struct AppScreenHeader<Trailing: View>: View {
    let title: String
    let subtitle: String?
    let leftIcon: String?
    let leftAction: (() -> Void)?
    @ViewBuilder let trailingContent: () -> Trailing

    public init(
        title: String,
        subtitle: String? = nil,
        leftIcon: String? = nil,
        leftAction: (() -> Void)? = nil,
        @ViewBuilder trailingContent: @escaping () -> Trailing = { EmptyView() }
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leftIcon = leftIcon
        self.leftAction = leftAction
        self.trailingContent = trailingContent
    }

    public var body: some View {
        HStack(alignment: .center) {
            if let leftIcon, let leftAction {
                Button(action: {
                    AppHaptics.light()
                    leftAction()
                }) {
                    Image(systemName: leftIcon)
                        .font(DesignTokens.IconTypography.large)
                        .foregroundColor(DesignTokens.Colors.textPrimary)
                }
                .accessibilityLabel(SystemStrings.Accessibility.navigateBack)
                .accessibilityAddTraits(.isButton)
            }

            VStack(alignment: .leading, spacing: DesignTokens.Spacing.tight) {
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

            trailingContent()
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .padding(.vertical, DesignTokens.Spacing.sm)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }
}
