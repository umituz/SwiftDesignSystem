import SwiftUI

// MARK: - ErrorStateView
public struct AppErrorStateView: View {
    let icon: String
    let title: String
    let message: String?
    let buttonTitle: String
    let buttonAction: () -> Void

    public init(
        icon: String = SystemStrings.StateIcons.errorState,
        title: String,
        message: String? = nil,
        buttonTitle: String = SystemStrings.Defaults.retryButton,
        buttonAction: @escaping () -> Void
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
            iconColor: DesignTokens.Colors.danger,
            title: title,
            message: message,
            buttonTitle: buttonTitle,
            buttonAction: buttonAction,
            accessibilityLabel: errorAccessibilityDescription
        )
    }

    private var errorAccessibilityDescription: String {
        var parts = [SystemStrings.errorPrefix(title)]
        if let message { parts.append(message) }
        return SystemStrings.joinedDescription(parts)
    }
}
