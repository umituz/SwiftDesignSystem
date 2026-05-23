import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Colors & Gradients
extension DesignTokens {

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
}
