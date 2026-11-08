import SwiftUI

// MARK: - Fade + Slide Transition
private struct FadeSlideModifier: ViewModifier {
    let isVisible: Bool
    let yOffset: CGFloat

    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : yOffset)
    }
}

extension View {
    /// Fades and slides a view in/out based on visibility — for step-by-step
    /// onboarding reveals and conditional section transitions.
    public func fadeSlide(isVisible: Bool, yOffset: CGFloat = DesignTokens.Spacing.xl) -> some View {
        modifier(FadeSlideModifier(isVisible: isVisible, yOffset: yOffset))
    }
}
