import Foundation

// MARK: - ProgressCalculation
public enum ProgressCalculation {

    public static func clamped(_ progress: Double) -> Double {
        max(0, min(progress, 1.0))
    }

    public static func percentageString(_ progress: Double) -> String {
        let value = Int(clamped(progress) * 100)
        return "\(value)%"
    }

    public static func accessibilityPercentString(_ progress: Double) -> String {
        let value = Int(clamped(progress) * 100)
        return "\(value) percent"
    }

    public static func barWidth(fraction: Double, availableWidth: CGFloat) -> CGFloat {
        availableWidth * clamped(fraction)
    }
}
