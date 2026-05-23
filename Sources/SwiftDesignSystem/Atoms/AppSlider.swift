import SwiftUI

// MARK: - AppSlider
public struct AppSlider: View {
    let label: String?
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let showValue: Bool
    let tint: Color
    let isDisabled: Bool

    @State private var lastHapticStep: Int = 0

    public init(
        label: String? = nil,
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        step: Double = 0.01,
        showValue: Bool = true,
        tint: Color = DesignTokens.Colors.primary,
        isDisabled: Bool = false
    ) {
        self.label = label
        self._value = value
        self.range = range
        self.step = step
        self.showValue = showValue
        self.tint = tint
        self.isDisabled = isDisabled
    }

    public var body: some View {
        let displayValue = clampedValue(from: value)

        VStack(spacing: DesignTokens.Spacing.xs) {
            if label != nil || showValue {
                sliderHeader(displayValue: displayValue)
            }

            sliderTrack(displayValue: displayValue)
        }
        .opacity(StyleResolution.disabledOpacity(isDisabled: isDisabled))
        .disabled(isDisabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? SystemStrings.Accessibility.slider)
        .accessibilityValue(formatAccessibility(displayValue))
    }

    private func sliderHeader(displayValue: Double) -> some View {
        HStack {
            if let label {
                Text(label)
                    .font(DesignTokens.Typography.footnote)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
            }

            Spacer()

            if showValue {
                Text(formatValue(displayValue))
                    .font(DesignTokens.Typography.captionBold)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
            }
        }
    }

    private func sliderTrack(displayValue: Double) -> some View {
        GeometryReader { geometry in
            let trackWidth = geometry.size.width
            let progress = progressFor(displayValue)
            let filledWidth = trackWidth * CGFloat(progress)

            ZStack(alignment: .leading) {
                trackBackground
                trackFill(filledWidth: filledWidth)
                thumbView(filledWidth: filledWidth, trackWidth: trackWidth)
            }
            .frame(height: DesignTokens.Sizing.sliderThumbSize)
            .gesture(dragGesture(trackWidth: trackWidth))
        }
        .frame(height: DesignTokens.Sizing.sliderThumbSize)
    }

    private var trackBackground: some View {
        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.full)
            .fill(DesignTokens.Colors.surface)
            .frame(height: DesignTokens.Sizing.sliderTrackHeight)
    }

    private func trackFill(filledWidth: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.full)
            .fill(tint)
            .frame(width: filledWidth, height: DesignTokens.Sizing.sliderTrackHeight)
    }

    private func thumbView(filledWidth: CGFloat, trackWidth: CGFloat) -> some View {
        Circle()
            .fill(DesignTokens.Colors.background)
            .frame(width: DesignTokens.Sizing.sliderThumbSize, height: DesignTokens.Sizing.sliderThumbSize)
            .overlay(
                Circle()
                    .fill(tint)
                    .frame(width: DesignTokens.Sizing.sliderThumbSize - DesignTokens.Border.thick * 2)
            )
            .shadow(color: .black.opacity(DesignTokens.Opacity.transparent), radius: 2, y: 1)
            .offset(x: thumbOffset(filledWidth: filledWidth, trackWidth: trackWidth))
    }

    private func clampedValue(from raw: Double) -> Double {
        if raw < range.lowerBound { return range.lowerBound }
        if raw > range.upperBound { return range.upperBound }
        return raw
    }

    private func progressFor(_ displayValue: Double) -> Double {
        let span = range.upperBound - range.lowerBound
        if span == 0 { return 0 }
        return (displayValue - range.lowerBound) / span
    }

    private func formatValue(_ displayValue: Double) -> String {
        String(format: "%.1f", displayValue)
    }

    private func formatAccessibility(_ displayValue: Double) -> String {
        String(format: SystemStrings.Accessibility.sliderValue + ": %.1f", displayValue)
    }

    private func thumbOffset(filledWidth: CGFloat, trackWidth: CGFloat) -> CGFloat {
        let halfThumb = DesignTokens.Sizing.sliderThumbSize / 2
        if filledWidth <= halfThumb { return 0 }
        if filledWidth >= trackWidth - halfThumb { return trackWidth - DesignTokens.Sizing.sliderThumbSize }
        return filledWidth - halfThumb
    }

    private func dragGesture(trackWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { drag in
                let span = range.upperBound - range.lowerBound
                if span == 0 { return }
                let progress = Double(drag.location.x / trackWidth)
                let rawValue = range.lowerBound + progress * span
                let steppedValue = round(rawValue / step) * step
                let clamped = max(range.lowerBound, min(range.upperBound, steppedValue))
                let currentStep = Int(round(clamped / step))
                if currentStep != lastHapticStep {
                    AppHaptics.selectionChanged()
                    lastHapticStep = currentStep
                }
                value = clamped
            }
    }
}
