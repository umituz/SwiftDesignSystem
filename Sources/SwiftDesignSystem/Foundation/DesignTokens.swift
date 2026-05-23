import SwiftUI

// MARK: - Shadow Model
public struct DesignShadow: Sendable, Equatable {
    public let color: Color
    public let radius: CGFloat
    // swiftlint:disable:next identifier_name
    public let y: CGFloat
    // swiftlint:disable:next identifier_name
    public init(color: Color, radius: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.y = y
    }
}

// MARK: - Design Tokens
public enum DesignTokens {}
