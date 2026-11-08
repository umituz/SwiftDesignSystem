import SwiftUI

// MARK: - Card Styles
/// Card container resolving its surface from the active theme — apps brand
/// their cards through `AppTheme.surface` without local wrapper modifiers.
private struct ThemedCardStyleModifier: ViewModifier {
    @Environment(\.appTheme) private var theme
    let padding: CGFloat
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

extension View {
    public func cardStyle(
        padding: CGFloat = DesignTokens.Spacing.lg,
        cornerRadius: CGFloat = DesignTokens.CornerRadius.lg
    ) -> some View {
        modifier(ThemedCardStyleModifier(padding: padding, cornerRadius: cornerRadius))
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

    /// Rounds only the given corners — chat bubbles, list section caps and
    /// hero headers that sit flush against an edge.
    #if canImport(UIKit)
    public func roundedCorners(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.clipShape(RoundedCornersShape(radius: radius, corners: corners))
    }
    #else
    public func roundedCorners(
        _ radius: CGFloat,
        topLeft: CGFloat = 0,
        bottomLeft: CGFloat = 0,
        bottomRight: CGFloat = 0,
        topRight: CGFloat = 0
    ) -> some View {
        self.clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: topLeft,
                bottomLeadingRadius: bottomLeft,
                bottomTrailingRadius: bottomRight,
                topTrailingRadius: topRight,
                style: .continuous
            )
        )
    }
    #endif
}

#if canImport(UIKit)
import UIKit

/// Legacy `UIRectCorner` adapter for `roundedCorners(_:corners:)` — public so
/// apps can use the shape directly in gradients and fills.
public struct RoundedCornersShape: Shape {
    public let radius: CGFloat
    public let corners: UIRectCorner

    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        Path(
            UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            ).cgPath
        )
    }
}
#endif

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
        content.padding(adaptivePadding)
    }

    private var adaptivePadding: CGFloat {
        AdaptiveValue(compact: compact, regular: regular)
            .resolve(for: horizontalSizeClass)
    }
}

// MARK: - Keyboard Dismissal
extension View {
    #if canImport(UIKit)
    public func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
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
