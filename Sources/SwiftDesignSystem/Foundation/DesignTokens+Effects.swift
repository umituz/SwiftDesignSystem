import SwiftUI

// MARK: - Shadows, Animations, Border & Opacity
extension DesignTokens {

    public enum Shadows {
        public static let subtle = DesignShadow(color: .black.opacity(0.06), radius: 4, y: 2)
        public static let medium = DesignShadow(color: .black.opacity(0.1), radius: 8, y: 4)
        public static let strong = DesignShadow(color: Colors.primary.opacity(0.3), radius: 16, y: 8)
        public static let cardTint = DesignShadow(color: Colors.primary.opacity(0.3), radius: 10, y: 5)
    }

    public enum Animations {
        public static let quick = Animation.easeOut(duration: 0.2)
        public static let standard = Animation.spring(response: 0.3, dampingFraction: 0.7)
        public static let slow = Animation.spring(response: 0.5, dampingFraction: 0.75)
        public static let bouncy = Animation.spring(response: 0.6, dampingFraction: 0.6)
        public static let progress = Animation.spring(duration: 0.8)
        public static let card = Animation.easeInOut(duration: 0.3)
        public static let expand = Animation.spring(response: 0.35, dampingFraction: 0.8)
        public static let button = Animation.easeInOut(duration: 0.15)
    }

    public enum Border {
        public static let thin: CGFloat = 0.5
        public static let regular: CGFloat = 1
        public static let thick: CGFloat = 2
    }

    public enum Opacity {
        public static let nearlyInvisible: Double = 0.05
        public static let veryTransparent: Double = 0.12
        public static let transparent: Double = 0.25
        public static let semiTransparent: Double = 0.5
        public static let barelyVisible: Double = 0.75
        public static let fullyVisible: Double = 1.0
        public static let shimmerOverlay: Double = 0.3
        public static let textOnTint: Double = 0.8
    }
}
