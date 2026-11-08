import SwiftUI

// MARK: - Badge Style
public enum AppBadgeStyle: Sendable {
    case pill
    case dot
    case count(Int)
}

// MARK: - AppBadge
public struct AppBadge: View {
    let text: String?
    let style: AppBadgeStyle
    let color: Color?

    @Environment(\.appTheme) private var theme

    public init(
        text: String? = nil,
        style: AppBadgeStyle = .pill,
        color: Color? = nil
    ) {
        self.text = text
        self.style = style
        self.color = color
    }

    /// Explicit color wins; otherwise the active theme accent is used.
    private var resolvedColor: Color {
        color ?? theme.accentPrimary
    }

    public var body: some View {
        switch style {
        case .pill:
            pillContent
        case .dot:
            dotContent
        case .count(let value):
            countContent(value)
        }
    }

    // MARK: - Content Variants

    private var pillContent: some View {
        Text(text ?? "")
            .font(DesignTokens.Typography.captionBold)
            .foregroundColor(theme.onAccent)
            .padding(.horizontal, DesignTokens.Spacing.sm)
            .padding(.vertical, DesignTokens.Spacing.xs)
            .background(resolvedColor)
            .clipShape(Capsule())
            .accessibilityLabel(text ?? SystemStrings.Accessibility.badge)
    }

    private var dotContent: some View {
        Circle()
            .fill(resolvedColor)
            .frame(width: DesignTokens.Spacing.sm, height: DesignTokens.Spacing.sm)
            .accessibilityLabel(SystemStrings.Accessibility.notificationIndicator)
    }

    private func countContent(_ value: Int) -> some View {
        Text(CountFormatter.displayString(for: value))
            .font(DesignTokens.Typography.caption2)
            .foregroundColor(theme.onAccent)
            .frame(
                minWidth: DesignTokens.Spacing.lg + DesignTokens.Spacing.xs,
                minHeight: DesignTokens.Spacing.lg + DesignTokens.Spacing.xs
            )
            .background(resolvedColor)
            .clipShape(Circle())
            .accessibilityLabel(CountFormatter.accessibilityString(for: value))
    }
}
