import SwiftUI

// MARK: - Adaptive Value
public struct AdaptiveValue<T> {
    public let compact: T
    public let regular: T

    public init(compact: T, regular: T) {
        self.compact = compact
        self.regular = regular
    }

    public func resolve(for sizeClass: UserInterfaceSizeClass?) -> T {
        if sizeClass == .regular {
            return regular
        }
        return compact
    }

    public static func constant(_ value: T) -> AdaptiveValue<T> {
        AdaptiveValue(compact: value, regular: value)
    }
}
