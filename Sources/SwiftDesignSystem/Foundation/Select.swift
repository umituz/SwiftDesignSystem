import Foundation

// MARK: - Conditional Value Selection

/// Picks between two values based on a condition — the shared primitive
/// behind the per-app `Theme.foreground(_:_)` / `Selection.color(...)`
/// helper families (berdo, Choiyre, aria) that this replaces.
///
/// ```swift
/// .opacity(select(isActive, 1.0, 0.5))
/// .foregroundStyle(select(isSelected, AppColors.primary, .secondary))
/// ```
@inlinable
public func select<T>(_ condition: Bool, _ whenTrue: T, _ whenFalse: T) -> T {
    condition ? whenTrue : whenFalse
}
