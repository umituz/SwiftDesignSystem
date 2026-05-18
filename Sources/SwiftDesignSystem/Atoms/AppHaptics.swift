import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public enum AppHaptics {

    #if canImport(UIKit)
    public static func light() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    public static func medium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    public static func heavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    public static func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    public static func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    public static func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    public static func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    #endif
}
