import Foundation

// MARK: - CountFormatter
public enum CountFormatter {

    public static let overflowThreshold = 99

    public static func displayString(for count: Int) -> String {
        if count > overflowThreshold {
            return "\(overflowThreshold)+"
        }
        return "\(count)"
    }

    public static func accessibilityString(for count: Int) -> String {
        if count > overflowThreshold {
            return "More than \(overflowThreshold) items"
        }
        return "\(count) items"
    }
}
