import SwiftUI

// MARK: - Progress Style
public enum AppProgressStyle {
    case linear
    case circular
}

// MARK: - AppProgressView
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
        self.progress = ProgressCalculation.clamped(progress)
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

    // MARK: - Circular

    private var circularContent: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            ZStack {
                Circle()
                    .stroke(backgroundColor, lineWidth: DesignTokens.Border.thick)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: DesignTokens.Border.thick, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(DesignTokens.Animations.progress, value: progress)

                Text(ProgressCalculation.percentageString(progress))
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
        .accessibilityElement(children: .combine)
        .accessibilityValue(ProgressCalculation.accessibilityPercentString(progress))
    }

    // MARK: - Linear

    private var linearContent: some View {
        VStack(spacing: DesignTokens.Spacing.xs) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.sm)
                        .fill(backgroundColor)

                    RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.sm)
                        .fill(color)
                        .frame(width: ProgressCalculation.barWidth(fraction: progress, availableWidth: geometry.size.width))
                        .animation(DesignTokens.Animations.progress, value: progress)
                }
            }
            .frame(height: DesignTokens.Sizing.linearProgressHeight)

            if let label {
                Text(label)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityValue(ProgressCalculation.accessibilityPercentString(progress))
    }
}
