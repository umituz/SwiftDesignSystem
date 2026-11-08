import SwiftUI

// MARK: - Conditional View Modifiers

extension View {

    /// Branches between two transforms based on `condition`.
    ///
    /// Companion to the single-branch ``SwiftUI/View/if(_:transform:)``;
    /// promoted from repeated app implementations (berdo, Choiyre).
    @ViewBuilder
    public func `if`<IfTrue: View, IfFalse: View>(
        _ condition: Bool,
        if ifTransform: (Self) -> IfTrue,
        else elseTransform: (Self) -> IfFalse
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }

    /// Applies `transform` with the unwrapped value when it is non-`nil`;
    /// otherwise returns the view unchanged.
    @ViewBuilder
    public func ifNotNil<Value, Transformed: View>(
        _ value: Value?,
        transform: (Self, Value) -> Transformed
    ) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
}
