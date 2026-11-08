import SwiftUI

// MARK: - State Style
/// Generic active/inactive value pair — replaces scattered ternaries with
/// named, testable style tokens (colors, weights, scales, opacities).
///
/// ```swift
/// extension Palette {
///     static let selection = StateStyle<Color>(active: .white, inactive: .secondary)
/// }
/// Text("Hi").styledForeground(isSelected, style: Palette.selection)
/// ```
public struct StateStyle<T> {
    public let active: T
    public let inactive: T

    public init(active: T, inactive: T) {
        self.active = active
        self.inactive = inactive
    }

    public func resolve(_ isActive: Bool) -> T {
        isActive ? active : inactive
    }
}

extension StateStyle: Sendable where T: Sendable {}
extension StateStyle: Equatable where T: Equatable {}
