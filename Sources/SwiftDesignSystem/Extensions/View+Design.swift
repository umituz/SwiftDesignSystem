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
            .shadow(color: DesignTokens.Colors.primary.opacity(0.3), radius: 16, y: 8)
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
