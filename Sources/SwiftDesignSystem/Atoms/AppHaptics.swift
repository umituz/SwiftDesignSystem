import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - AppHaptics
public enum AppHaptics {

    #if canImport(UIKit)
    private static let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    private static let mediumGenerator = UIImpactFeedbackGenerator(style: .medium)
    private static let heavyGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private static let selectionGenerator = UISelectionFeedbackGenerator()

    public static func prepare() {
        lightGenerator.prepare()
        mediumGenerator.prepare()
        heavyGenerator.prepare()
        selectionGenerator.prepare()
    }

    public static func light() {
        lightGenerator.impactOccurred()
    }

    public static func medium() {
        mediumGenerator.impactOccurred()
    }

    public static func heavy() {
        heavyGenerator.impactOccurred()
    }

    public static func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }

    public static func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.warning)
    }

    public static func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.error)
    }

    public static func selectionChanged() {
        selectionGenerator.selectionChanged()
    }
    #else
    public static func prepare() {}
    public static func light() {}
    public static func medium() {}
    public static func heavy() {}
    public static func success() {}
    public static func warning() {}
    public static func error() {}
    public static func selectionChanged() {}
    #endif
}
