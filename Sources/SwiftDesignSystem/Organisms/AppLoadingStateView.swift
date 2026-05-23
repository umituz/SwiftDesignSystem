import SwiftUI

// MARK: - LoadingStateView
public struct AppLoadingStateView: View {
    let message: String?

    public init(message: String? = nil) {
        self.message = message
    }

    public var body: some View {
        VStack(spacing: DesignTokens.Spacing.lg) {
            ProgressView()
                .controlSize(.large)
                .tint(DesignTokens.Colors.primary)

            if let message {
                Text(message)
                    .font(DesignTokens.Typography.subheadline)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message ?? SystemStrings.Accessibility.loading)
    }
}
