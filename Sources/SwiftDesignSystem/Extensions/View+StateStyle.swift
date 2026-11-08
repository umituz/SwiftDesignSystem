import SwiftUI

// MARK: - State-Styled Views
/// Applies `StateStyle` tokens through the modifier chain so call sites read
/// declaratively instead of branching on booleans by hand.
extension View {

    public func styledForeground(_ isActive: Bool, style: StateStyle<Color>) -> some View {
        foregroundStyle(style.resolve(isActive))
    }

    public func styledBackground(_ isActive: Bool, style: StateStyle<Color>) -> some View {
        background(style.resolve(isActive))
    }

    public func styledStroke(
        _ isActive: Bool,
        style: StateStyle<Color>,
        lineWidth: CGFloat = 1,
        cornerRadius: CGFloat = DesignTokens.CornerRadius.sm
    ) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(style.resolve(isActive), lineWidth: lineWidth)
        )
    }

    public func styledOpacity(_ isActive: Bool, style: StateStyle<Double>) -> some View {
        opacity(style.resolve(isActive))
    }

    public func styledScale(_ isActive: Bool, style: StateStyle<CGFloat>) -> some View {
        scaleEffect(style.resolve(isActive))
    }

    public func styledFontWeight(
        _ isActive: Bool,
        style: StateStyle<Font.Weight>,
        base: Font = .subheadline
    ) -> some View {
        font(base.weight(style.resolve(isActive)))
    }

    /// Marks selectable rows/chips so VoiceOver announces "selected" — pairs
    /// with the visual selection styles above. An optional `hint` (e.g.
    /// "Double tap to deselect") reads as the accessibility hint.
    @ViewBuilder
    public func styledSelectionAccessibility(_ isSelected: Bool, hint: String? = nil) -> some View {
        if let hint {
            self
                .accessibilityAddTraits(isSelected ? .isSelected : [])
                .accessibilityHint(hint)
        } else {
            self
                .accessibilityAddTraits(isSelected ? .isSelected : [])
        }
    }
}
