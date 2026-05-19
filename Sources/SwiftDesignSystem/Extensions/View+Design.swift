import SwiftUI

// MARK: - Card Styles
extension View {
    public func cardStyle(
        padding: CGFloat = DesignTokens.Spacing.lg,
        cornerRadius: CGFloat = DesignTokens.CornerRadius.lg
    ) -> some View {
        self
            .padding(padding)
            .background(DesignTokens.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

    public func primaryCardStyle(
        cornerRadius: CGFloat = DesignTokens.CornerRadius.xl
    ) -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignTokens.Spacing.xxxl)
            .background(DesignTokens.Gradients.hero)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .appShadow(DesignTokens.Shadows.strong)
    }
}

// MARK: - Shadow
extension View {
    public func appShadow(_ shadow: DesignShadow) -> some View {
        self.shadow(color: shadow.color, radius: shadow.radius, y: shadow.y)
    }
}

// MARK: - Corner Radius
extension View {
    public func appCornerRadius(_ radius: CGFloat) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

// MARK: - Responsive Padding
extension View {
    public func responsivePadding(
        compact: CGFloat = DesignTokens.Spacing.lg,
        regular: CGFloat = DesignTokens.Spacing.xl
    ) -> some View {
        self.modifier(ResponsivePaddingModifier(compact: compact, regular: regular))
    }
}

private struct ResponsivePaddingModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let compact: CGFloat
    let regular: CGFloat

    func body(content: Content) -> some View {
        content.padding(horizontalSizeClass == .compact ? compact : regular)
    }
}

// MARK: - Keyboard Dismissal
extension View {
    #if canImport(UIKit)
    public func hideKeyboard() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    #endif
}

// MARK: - Themed Background
extension View {
    public func themedBackground() -> some View {
        self.background(DesignTokens.Colors.background)
    }

    public func groupedBackground() -> some View {
        self.background(DesignTokens.Colors.groupedBackground)
    }
}

// MARK: - Conditional Modifier
extension View {
    @ViewBuilder
    public func `if`(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Glass Morphism
extension View {
    public func glassMorphism(cornerRadius: CGFloat = DesignTokens.CornerRadius.lg) -> some View {
        self.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

// MARK: - Shimmer Effect
extension View {
    public func shimmer(isActive: Bool) -> some View {
        self.overlay(
            LinearGradient(
                colors: [.clear, DesignTokens.Colors.textOnPrimary.opacity(DesignTokens.Opacity.shimmerOverlay), .clear],
                startPoint: isActive ? .leading : .trailing,
                endPoint: isActive ? .trailing : .leading
            )
        )
        .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: isActive)
    }
}

// MARK: - Rounded Corner Shape
public struct RoundedCorner: Shape {
    public let topLeft: CGFloat
    public let topRight: CGFloat
    public let bottomLeft: CGFloat
    public let bottomRight: CGFloat

    public init(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height

        path.move(to: CGPoint(x: w - topRight, y: 0))
        path.addLine(to: CGPoint(x: w, y: topRight))
        path.addArc(center: CGPoint(x: w - topRight, y: topRight), radius: topRight, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - bottomRight))
        path.addArc(center: CGPoint(x: w - bottomRight, y: h - bottomRight), radius: bottomRight, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bottomLeft, y: h))
        path.addArc(center: CGPoint(x: bottomLeft, y: h - bottomLeft), radius: bottomLeft, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        path.closeSubpath()
        return path
    }
}

// MARK: - Per-Corner Radius
extension View {
    public func cornerRadius(_ topLeft: CGFloat, _ topRight: CGFloat, _ bottomLeft: CGFloat, _ bottomRight: CGFloat) -> some View {
        clipShape(RoundedCorner(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight))
    }
}
