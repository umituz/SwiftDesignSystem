import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Typography
extension DesignTokens {

    public enum Typography {
        #if canImport(UIKit)
        public static var display: Font {
            scaled(baseSize: 44, weight: .bold, design: .rounded, textStyle: .largeTitle)
        }
        public static var largeTitle: Font {
            scaled(baseSize: 34, weight: .bold, design: .rounded, textStyle: .largeTitle)
        }
        public static var title: Font {
            scaled(baseSize: 22, weight: .bold, design: .rounded, textStyle: .title1)
        }
        public static var title2: Font {
            scaled(baseSize: 20, weight: .semibold, design: .rounded, textStyle: .title2)
        }
        public static var title3: Font {
            scaled(baseSize: 18, weight: .semibold, design: .rounded, textStyle: .title3)
        }
        public static var headline: Font {
            scaled(baseSize: 17, weight: .semibold, textStyle: .headline)
        }
        public static var body: Font {
            scaled(baseSize: 17, weight: .regular, textStyle: .body)
        }
        public static var bodyBold: Font {
            scaled(baseSize: 17, weight: .semibold, textStyle: .body)
        }
        public static var callout: Font {
            scaled(baseSize: 16, weight: .regular, textStyle: .callout)
        }
        public static var calloutBold: Font {
            scaled(baseSize: 16, weight: .semibold, textStyle: .callout)
        }
        public static var subheadline: Font {
            scaled(baseSize: 15, weight: .regular, textStyle: .subheadline)
        }
        public static var subheadlineBold: Font {
            scaled(baseSize: 15, weight: .semibold, textStyle: .subheadline)
        }
        public static var footnote: Font {
            scaled(baseSize: 13, weight: .regular, textStyle: .footnote)
        }
        public static var caption: Font {
            scaled(baseSize: 12, weight: .regular, textStyle: .caption1)
        }
        public static var captionBold: Font {
            scaled(baseSize: 12, weight: .semibold, textStyle: .caption1)
        }
        public static var caption2: Font {
            scaled(baseSize: 11, weight: .regular, textStyle: .caption2)
        }

        public static func scaled(
            baseSize: CGFloat,
            weight: Font.Weight = .regular,
            design: Font.Design = .default,
            textStyle: UIFont.TextStyle = .body
        ) -> Font {
            let metrics = UIFontMetrics(forTextStyle: textStyle)
            let scaledSize = metrics.scaledValue(for: baseSize)
            return Font.system(size: scaledSize, weight: weight, design: design)
        }
        #else
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
        #endif
    }

    public enum IconTypography {
        public static let small = Font.system(size: DesignTokens.Sizing.iconSmall)
        public static let medium = Font.system(size: DesignTokens.Sizing.iconMedium)
        public static let large = Font.system(size: DesignTokens.Sizing.iconLarge)
        public static let xLarge = Font.system(size: DesignTokens.Sizing.iconXLarge)
        public static let hero = Font.system(size: DesignTokens.Sizing.iconHero)

        public static let chevron = Font.system(size: DesignTokens.Sizing.iconSmall, weight: .semibold)
        public static let dismiss = Font.system(size: DesignTokens.Sizing.iconSmall, weight: .semibold)
    }
}
