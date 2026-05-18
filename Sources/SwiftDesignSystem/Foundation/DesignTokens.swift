import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Shadow Model
public struct DesignShadow: Sendable, Equatable {
    public let color: Color
    public let radius: CGFloat
    public let y: CGFloat

    public init(color: Color, radius: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.y = y
    }
}

// MARK: - Design Tokens
public enum DesignTokens {

    // MARK: - Colors
    public enum Colors {
        public static let primary = Color(red: 0.39, green: 0.4, blue: 0.95)
        public static let secondary = Color(red: 0.55, green: 0.36, blue: 0.96)
        public static let accent = Color(red: 0.65, green: 0.55, blue: 0.98)

        public static let success = Color(red: 0.06, green: 0.73, blue: 0.51)
        public static let warning = Color(red: 0.98, green: 0.45, blue: 0.09)
        public static let danger = Color(red: 0.94, green: 0.26, blue: 0.26)
        public static let info = Color(red: 0.27, green: 0.72, blue: 0.82)

        #if canImport(UIKit)
        public static let background = Color(UIColor.systemBackground)
        public static let surface = Color(UIColor.secondarySystemBackground)
        public static let surfaceElevated = Color(UIColor.tertiarySystemBackground)
        public static let groupedBackground = Color(UIColor.systemGroupedBackground)
        #else
        public static let background = Color(.textBackgroundColor)
        public static let surface = Color(.controlBackgroundColor)
        public static let surfaceElevated = Color(.controlBackgroundColor)
        public static let groupedBackground = Color(.controlBackgroundColor)
        #endif

        #if canImport(UIKit)
        public static let textPrimary = Color(UIColor.label)
        public static let textSecondary = Color(UIColor.secondaryLabel)
        public static let textTertiary = Color(UIColor.tertiaryLabel)
        #else
        public static let textPrimary = Color.primary
        public static let textSecondary = Color.secondary
        public static let textTertiary = Color.secondary.opacity(0.6)
        #endif
        public static let textOnPrimary = Color.white

        #if canImport(UIKit)
        public static let separator = Color(UIColor.separator)
        public static let fill = Color(UIColor.systemFill)
        #else
        public static let separator = Color(.separatorColor)
        public static let fill = Color.gray.opacity(0.2)
        #endif

        public static let overlay = Color.black.opacity(0.4)
    }

    // MARK: - Gradients
    public enum Gradients {
        public static let hero = LinearGradient(
            colors: [Colors.primary, Colors.secondary, Colors.accent],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        public static let card = LinearGradient(
            colors: [Colors.primary.opacity(0.1), Colors.accent.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        public static let success = LinearGradient(
            colors: [Colors.success, Colors.success.opacity(0.7)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        public static let fade = LinearGradient(
            colors: [Color.clear, Colors.background.opacity(0.8)],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    // MARK: - Typography
    public enum Typography {
        public static let display = Font.system(size: 44, weight: .bold, design: .rounded)
        public static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
        public static let title = Font.system(size: 22, weight: .bold, design: .rounded)
        public static let title2 = Font.system(size: 20, weight: .semibold, design: .rounded)
        public static let title3 = Font.system(size: 18, weight: .semibold, design: .rounded)
        public static let headline = Font.system(size: 17, weight: .semibold)
        public static let body = Font.system(size: 17, weight: .regular)
        public static let bodyBold = Font.system(size: 17, weight: .semibold)
        public static let callout = Font.system(size: 16, weight: .regular)
        public static let calloutBold = Font.system(size: 16, weight: .semibold)
        public static let subheadline = Font.system(size: 15, weight: .regular)
        public static let subheadlineBold = Font.system(size: 15, weight: .semibold)
        public static let footnote = Font.system(size: 13, weight: .regular)
        public static let caption = Font.system(size: 12, weight: .regular)
        public static let captionBold = Font.system(size: 12, weight: .semibold)
        public static let caption2 = Font.system(size: 11, weight: .regular)
    }

    // MARK: - Spacing
    public enum Spacing {
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 20
        public static let xxl: CGFloat = 24
        public static let xxxl: CGFloat = 32
        public static let huge: CGFloat = 48
    }

    // MARK: - Corner Radius
    public enum CornerRadius {
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 20
        public static let xxl: CGFloat = 24
        public static let full: CGFloat = 999
    }

    // MARK: - Sizing
    public enum Sizing {
        public static let iconSmall: CGFloat = 16
        public static let iconMedium: CGFloat = 20
        public static let iconLarge: CGFloat = 24
        public static let iconXLarge: CGFloat = 32
        public static let iconXXLarge: CGFloat = 48
        public static let iconHero: CGFloat = 64

        public static let badgeSmall: CGFloat = 32
        public static let badgeMedium: CGFloat = 42
        public static let badgeLarge: CGFloat = 56
        public static let badgeXLarge: CGFloat = 80

        public static let buttonHeight: CGFloat = 48
        public static let textFieldHeight: CGFloat = 48
        public static let searchBarHeight: CGFloat = 36
        public static let listItemHeight: CGFloat = 56

        public static let chartHeight: CGFloat = 200
        public static let heroCircle: CGFloat = 180

        public static let iPadMaxWidth: CGFloat = 700
        public static let maxContentWidth: CGFloat = 900
        public static let maxCardWidth: CGFloat = 650
    }

    // MARK: - Shadows
    public enum Shadows {
        public static let subtle = DesignShadow(color: .black.opacity(0.06), radius: 4, y: 2)
        public static let medium = DesignShadow(color: .black.opacity(0.1), radius: 8, y: 4)
        public static let strong = DesignShadow(color: Colors.primary.opacity(0.3), radius: 16, y: 8)
    }

    // MARK: - Animations
    public enum Animations {
        public static let quick = Animation.easeOut(duration: 0.2)
        public static let standard = Animation.spring(response: 0.3, dampingFraction: 0.7)
        public static let slow = Animation.spring(response: 0.5, dampingFraction: 0.75)
        public static let bouncy = Animation.spring(response: 0.6, dampingFraction: 0.6)
        public static let progress = Animation.spring(duration: 0.8)
        public static let card = Animation.easeInOut(duration: 0.3)
        public static let button = Animation.easeInOut(duration: 0.15)
    }

    // MARK: - Border
    public enum Border {
        public static let thin: CGFloat = 0.5
        public static let regular: CGFloat = 1
        public static let thick: CGFloat = 2
    }

    // MARK: - Opacity
    public enum Opacity {
        public static let nearlyInvisible: Double = 0.05
        public static let veryTransparent: Double = 0.12
        public static let transparent: Double = 0.25
        public static let semiTransparent: Double = 0.5
        public static let barelyVisible: Double = 0.75
        public static let fullyVisible: Double = 1.0
    }

    // MARK: - Z-Index Layers
    public enum Layer {
        public static let background: CGFloat = 0
        public static let content: CGFloat = 1
        public static let overlay: CGFloat = 100
        public static let modal: CGFloat = 200
        public static let toast: CGFloat = 300
        public static let tooltip: CGFloat = 400
    }

    // MARK: - Breakpoints
    public enum Breakpoint {
        public static let compact: CGFloat = 375
        public static let regular: CGFloat = 430
        public static let tablet: CGFloat = 768
        public static let largeTablet: CGFloat = 1024

        public static func isCompact(width: CGFloat) -> Bool {
            width < compact
        }

        public static func isRegular(width: CGFloat) -> Bool {
            width >= compact && width < tablet
        }

        public static func isTablet(width: CGFloat) -> Bool {
            width >= tablet
        }

        public static func isLargeTablet(width: CGFloat) -> Bool {
            width >= largeTablet
        }
    }
}
