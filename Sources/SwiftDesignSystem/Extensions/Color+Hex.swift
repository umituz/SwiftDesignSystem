import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Hex Colors
/// Hex-string conversion and shade adjustment — the standard way brand and
/// product palettes defined in code enter the design system.
public extension Color {

    /// Initializes a color from a hex string (RGB, RGBA, RRGGBB or RRGGBBAA).
    /// Invalid input resolves to black, mirroring the common `#000000` fallback.
    init(hex: String) {
        let sanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&value)

        func channel(_ shift: UInt64) -> Double {
            Double((value >> shift) & 0xFF) / 255
        }

        let alpha: Double
        let red: Double
        let green: Double
        let blue: Double

        switch sanitized.count {
        case 3:
            // Shorthand: duplicate each digit (F00 → FF0000).
            func nibble(_ shift: UInt64) -> Double {
                Double((value >> shift) & 0xF) / 15
            }
            (alpha, red, green, blue) = (1, nibble(8), nibble(4), nibble(0))
        case 4:
            // Shorthand with alpha (FF00 → opaque red).
            func nibble(_ shift: UInt64) -> Double {
                Double((value >> shift) & 0xF) / 15
            }
            (alpha, red, green, blue) = (nibble(12), nibble(8), nibble(4), nibble(0))
        case 6:
            (alpha, red, green, blue) = (1, channel(16), channel(8), channel(0))
        case 8:
            (alpha, red, green, blue) = (channel(24), channel(16), channel(8), channel(0))
        default:
            (alpha, red, green, blue) = (1, 0, 0, 0)
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Renders the color as an uppercase `RRGGBB` hex string; black when the
    /// color cannot be resolved in the RGB space.
    func toHex() -> String {
        let rgba = rgbaComponents ?? RGBA(red: 0, green: 0, blue: 0, alpha: 1)
        return String(
            format: "%02X%02X%02X",
            Int((rgba.red * 255).rounded()),
            Int((rgba.green * 255).rounded()),
            Int((rgba.blue * 255).rounded())
        )
    }

    /// Lightens the color towards white by `0...1`; values outside the range clamp.
    func lighten(by percentage: Double) -> Color {
        shade(percentage, towards: 1)
    }

    /// Darkens the color towards black by `0...1`; values outside the range clamp.
    func darken(by percentage: Double) -> Color {
        shade(percentage, towards: 0)
    }

    private func shade(_ percentage: Double, towards target: Double) -> Color {
        let factor = min(1, max(0, percentage))
        let rgba = rgbaComponents ?? RGBA(red: 0, green: 0, blue: 0, alpha: 1)
        let mix: (Double) -> Double = { $0 + (target - $0) * factor }
        return Color(
            .sRGB,
            red: mix(rgba.red),
            green: mix(rgba.green),
            blue: mix(rgba.blue),
            opacity: rgba.alpha
        )
    }

    private var rgbaComponents: RGBA? {
        #if canImport(UIKit)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        return RGBA(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
        #elseif canImport(AppKit)
        guard let nsColor = NSColor(self).usingColorSpace(.deviceRGB) else {
            return nil
        }
        return RGBA(
            red: Double(nsColor.redComponent),
            green: Double(nsColor.greenComponent),
            blue: Double(nsColor.blueComponent),
            alpha: Double(nsColor.alphaComponent)
        )
        #else
        return nil
        #endif
    }
}

/// Raw linear-channel readout used by `toHex()` and the shade helpers.
private struct RGBA {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
