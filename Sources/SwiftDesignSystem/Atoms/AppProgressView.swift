import SwiftUI

public enum AppProgressStyle {
    case linear
    case circular
}

public struct AppProgressView: View {
    let progress: Double
    let style: AppProgressStyle
    let color: Color
    let backgroundColor: Color
    let label: String?

    public init(
        progress: Double,
        style: AppProgressStyle = .circular,
        color: Color = DesignTokens.Colors.primary,
        backgroundColor: Color = DesignTokens.Colors.surface,
        label: String? = nil
    ) {
        self.progress = progress
        self.style = style
        self.color = color
        self.backgroundColor = backgroundColor
        self.label = label
    }

    public var body: some View {
        switch style {
        case .circular:
            circularContent
        case .linear:
            linearContent
        }
    }

    private var circularContent: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            ZStack {
                Circle()
                    .stroke(backgroundColor, lineWidth: DesignTokens.Border.thick)

                Circle()
                    .trim(from: 0, to: min(progress, 1.0))
                    .stroke(color, style: StrokeStyle(lineWidth: DesignTokens.Border.thick, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(DesignTokens.Animations.progress, value: progress)

                Text("\(Int(progress * 100))%")
                    .font(DesignTokens.Typography.captionBold)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
            }
            .aspectRatio(1, contentMode: .fit)

            if let label {
                Text(label)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
            }
        }
    }

    private var linearContent: some View {
        VStack(spacing: DesignTokens.Spacing.xs) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.sm)
                        .fill(backgroundColor)

                    RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.sm)
                        .fill(color)
                        .frame(width: geometry.size.width * min(progress, 1.0))
                        .animation(DesignTokens.Animations.progress, value: progress)
                }
            }
            .frame(height: 6)

            if let label {
                Text(label)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}
