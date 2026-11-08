import SwiftUI

/// Horizontal step indicator for onboarding and multi-step flows:
/// a capsule for the current step, filled dots for completed steps,
/// faint dots for upcoming steps. Colors resolve from the active theme.
public struct AppStepIndicator: View {
    let stepCount: Int
    let currentStep: Int

    @Environment(\.appTheme) private var theme

    public init(stepCount: Int, currentStep: Int) {
        self.stepCount = stepCount
        self.currentStep = currentStep
    }

    public var body: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            ForEach(0..<max(stepCount, 0), id: \.self) { step in
                indicator(for: step)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(SystemStrings.Accessibility.stepIndicator)
        .accessibilityValue("\(currentStep + 1) / \(stepCount)")
    }

    @ViewBuilder
    private func indicator(for step: Int) -> some View {
        Capsule()
            .fill(fillColor(for: step))
            .frame(width: width(for: step), height: DesignTokens.Border.thick)
            .animation(DesignTokens.Animations.card, value: currentStep)
    }

    private func fillColor(for step: Int) -> Color {
        if step < currentStep {
            theme.accentPrimary
        } else if step == currentStep {
            theme.accentPrimary
        } else {
            theme.accentPrimary.opacity(DesignTokens.Opacity.veryTransparent)
        }
    }

    private func width(for step: Int) -> CGFloat {
        step == currentStep ? DesignTokens.Spacing.xl : DesignTokens.Spacing.sm
    }
}
