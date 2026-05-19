import SwiftUI

// MARK: - Badge Style
public enum AppBadgeStyle {
    case pill
    case dot
    case count(Int)
}

// MARK: - AppBadge
public struct AppBadge: View {
    let text: String?
    let style: AppBadgeStyle
    let color: Color

    public init(
        text: String? = nil,
        style: AppBadgeStyle = .pill,
        color: Color = DesignTokens.Colors.primary
    ) {
        self.text = text
        self.style = style
        self.color = color
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
            .foregroundColor(DesignTokens.Colors.textOnPrimary)
            .padding(.horizontal, DesignTokens.Spacing.sm)
            .padding(.vertical, DesignTokens.Spacing.xs)
            .background(color)
            .clipShape(Capsule())
            .accessibilityLabel(text ?? "Badge")
    }

    private var dotContent: some View {
        Circle()
            .fill(color)
            .frame(width: DesignTokens.Spacing.sm, height: DesignTokens.Spacing.sm)
            .accessibilityLabel("Notification indicator")
    }

    private func countContent(_ value: Int) -> some View {
        let display = value > 99 ? "99+" : "\(value)"
        return Text(display)
            .font(DesignTokens.Typography.caption2)
            .foregroundColor(DesignTokens.Colors.textOnPrimary)
            .frame(
                minWidth: DesignTokens.Spacing.lg + DesignTokens.Spacing.xs,
                minHeight: DesignTokens.Spacing.lg + DesignTokens.Spacing.xs
            )
            .background(color)
            .clipShape(Circle())
            .accessibilityLabel("\(value) items")
    }
}
