import SwiftUI

// MARK: - Layer & Breakpoint
extension DesignTokens {

    public enum Layer {
        public static let background: CGFloat = 0
        public static let content: CGFloat = 1
        public static let overlay: CGFloat = 100
        public static let modal: CGFloat = 200
        public static let toast: CGFloat = 300
        public static let tooltip: CGFloat = 400
    }

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
