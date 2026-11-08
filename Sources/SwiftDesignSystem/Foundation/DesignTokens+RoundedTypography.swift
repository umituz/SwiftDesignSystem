import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Rounded Typography
/// Rounded-design variants of the full text scale. Friendly consumer apps
/// (wellness, family, education) use these for every label so the whole
/// product shares one soft voice. Base `Typography` titles are already
/// rounded; this namespace makes the ENTIRE scale rounded for apps that
/// want it, without checking style-by-style.
extension DesignTokens {

    public enum RoundedTypography {
        #if canImport(UIKit)
        public static var displayXL: Font {
            DesignTokens.Typography.scaled(baseSize: 58, weight: .bold, design: .rounded, textStyle: .largeTitle)
        }
        public static var display: Font {
            DesignTokens.Typography.scaled(baseSize: 44, weight: .bold, design: .rounded, textStyle: .largeTitle)
        }
        public static var largeTitle: Font {
            DesignTokens.Typography.scaled(baseSize: 34, weight: .bold, design: .rounded, textStyle: .largeTitle)
        }
        public static var title: Font {
            DesignTokens.Typography.scaled(baseSize: 22, weight: .bold, design: .rounded, textStyle: .title1)
        }
        public static var title2: Font {
            DesignTokens.Typography.scaled(baseSize: 20, weight: .semibold, design: .rounded, textStyle: .title2)
        }
        public static var title3: Font {
            DesignTokens.Typography.scaled(baseSize: 18, weight: .semibold, design: .rounded, textStyle: .title3)
        }
        public static var headline: Font {
            DesignTokens.Typography.scaled(baseSize: 17, weight: .semibold, design: .rounded, textStyle: .headline)
        }
        public static var body: Font {
            DesignTokens.Typography.scaled(baseSize: 17, weight: .regular, design: .rounded, textStyle: .body)
        }
        public static var bodyBold: Font {
            DesignTokens.Typography.scaled(baseSize: 17, weight: .semibold, design: .rounded, textStyle: .body)
        }
        public static var callout: Font {
            DesignTokens.Typography.scaled(baseSize: 16, weight: .regular, design: .rounded, textStyle: .callout)
        }
        public static var calloutBold: Font {
            DesignTokens.Typography.scaled(baseSize: 16, weight: .semibold, design: .rounded, textStyle: .callout)
        }
        public static var subheadline: Font {
            DesignTokens.Typography.scaled(baseSize: 15, weight: .regular, design: .rounded, textStyle: .subheadline)
        }
        public static var subheadlineBold: Font {
            DesignTokens.Typography.scaled(baseSize: 15, weight: .semibold, design: .rounded, textStyle: .subheadline)
        }
        public static var footnote: Font {
            DesignTokens.Typography.scaled(baseSize: 13, weight: .regular, design: .rounded, textStyle: .footnote)
        }
        public static var footnoteBold: Font {
            DesignTokens.Typography.scaled(baseSize: 13, weight: .semibold, design: .rounded, textStyle: .footnote)
        }
        public static var caption: Font {
            DesignTokens.Typography.scaled(baseSize: 12, weight: .regular, design: .rounded, textStyle: .caption1)
        }
        public static var captionBold: Font {
            DesignTokens.Typography.scaled(baseSize: 12, weight: .semibold, design: .rounded, textStyle: .caption1)
        }
        public static var caption2: Font {
            DesignTokens.Typography.scaled(baseSize: 11, weight: .regular, design: .rounded, textStyle: .caption2)
        }
        #else
        public static let displayXL = Font.system(size: 58, weight: .bold, design: .rounded)
        public static let display = Font.system(size: 44, weight: .bold, design: .rounded)
        public static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
        public static let title = Font.system(size: 22, weight: .bold, design: .rounded)
        public static let title2 = Font.system(size: 20, weight: .semibold, design: .rounded)
        public static let title3 = Font.system(size: 18, weight: .semibold, design: .rounded)
        public static let headline = Font.system(size: 17, weight: .semibold, design: .rounded)
        public static let body = Font.system(size: 17, weight: .regular, design: .rounded)
        public static let bodyBold = Font.system(size: 17, weight: .semibold, design: .rounded)
        public static let callout = Font.system(size: 16, weight: .regular, design: .rounded)
        public static let calloutBold = Font.system(size: 16, weight: .semibold, design: .rounded)
        public static let subheadline = Font.system(size: 15, weight: .regular, design: .rounded)
        public static let subheadlineBold = Font.system(size: 15, weight: .semibold, design: .rounded)
        public static let footnote = Font.system(size: 13, weight: .regular, design: .rounded)
        public static let footnoteBold = Font.system(size: 13, weight: .semibold, design: .rounded)
        public static let caption = Font.system(size: 12, weight: .regular, design: .rounded)
        public static let captionBold = Font.system(size: 12, weight: .semibold, design: .rounded)
        public static let caption2 = Font.system(size: 11, weight: .regular, design: .rounded)
        #endif
    }
}
