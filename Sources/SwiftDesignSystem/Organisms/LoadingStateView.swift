import SwiftUI

public struct LoadingStateView: View {
    let message: String?

    public init(message: String? = nil) {
        self.message = message
    }

    public var body: some View {
        VStack(spacing: DesignTokens.Spacing.lg) {
            ProgressView()
                .scaleEffect(1.2)
                .tint(DesignTokens.Colors.primary)

            if let message {
                Text(message)
                    .font(DesignTokens.Typography.subheadline)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
