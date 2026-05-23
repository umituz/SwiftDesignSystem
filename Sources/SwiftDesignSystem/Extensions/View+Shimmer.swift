import SwiftUI

// MARK: - Shimmer Effect
extension View {
    public func shimmer(isActive: Bool) -> some View {
        self.modifier(ShimmerModifier(isActive: isActive))
    }
}

private struct ShimmerModifier: ViewModifier {
    let isActive: Bool

    private static let shimmerSpread: CGFloat = 0.2
    private static let shimmerDuration: Double = 1.5

    @State private var phase: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: max(0, phase - Self.shimmerSpread)),
                        .init(color: DesignTokens.Colors.textOnPrimary.opacity(DesignTokens.Opacity.shimmerOverlay), location: phase),
                        .init(color: .clear, location: min(1, phase + Self.shimmerSpread))
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(content)
            )
            .onAppear {
                guard isActive else { return }
                withAnimation(.linear(duration: Self.shimmerDuration).repeatForever(autoreverses: false)) {
                    phase = 2
                }
            }
            .onChange(of: isActive) { _, newValue in
                if newValue {
                    phase = -1
                    withAnimation(.linear(duration: Self.shimmerDuration).repeatForever(autoreverses: false)) {
                        phase = 2
                    }
                } else {
                    withAnimation(DesignTokens.Animations.quick) {
                        phase = -1
                    }
                }
            }
    }
}
