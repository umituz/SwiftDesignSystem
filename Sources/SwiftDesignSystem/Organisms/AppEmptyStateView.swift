import SwiftUI

// MARK: - EmptyStateView
public struct AppEmptyStateView: View {
    let icon: String
    let title: String
    let message: String?
    let buttonTitle: String?
    let buttonAction: (() -> Void)?

    public init(
        icon: String = SystemStrings.StateIcons.emptyState,
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
        AppStateLayout(
            icon: icon,
            iconColor: DesignTokens.Colors.textTertiary,
            title: title,
            message: message,
            buttonTitle: buttonTitle,
            buttonAction: buttonAction
        )
    }
}
