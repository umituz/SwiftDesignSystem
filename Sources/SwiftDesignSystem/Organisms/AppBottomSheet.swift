import SwiftUI

// MARK: - Bottom Sheet Detent
public enum AppBottomSheetDetent {
    case medium
    case large
    case custom(CGFloat)

    @available(iOS 16.0, macOS 13.0, *)
    var presentationDetent: PresentationDetent {
        switch self {
        case .medium: return .medium
        case .large: return .large
        case .custom(let height): return .height(height)
        }
    }
}

// MARK: - Bottom Sheet Modifier
public struct AppBottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let detent: AppBottomSheetDetent
    let showDragIndicator: Bool
    let onDismiss: (() -> Void)?
    @ViewBuilder let sheetContent: () -> SheetContent

    public init(
        isPresented: Binding<Bool>,
        detent: AppBottomSheetDetent = .medium,
        showDragIndicator: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self._isPresented = isPresented
        self.detent = detent
        self.showDragIndicator = showDragIndicator
        self.onDismiss = onDismiss
        self.sheetContent = sheetContent
    }

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                sheetContent()
                    .presentationDetents([detent.presentationDetent])
                    .presentationDragIndicator(showDragIndicator ? .visible : .hidden)
                    .presentationBackgroundInteraction(.enabled)
                    .presentationCornerRadius(DesignTokens.CornerRadius.xl)
            }
    }
}

// MARK: - View Extension
extension View {
    public func appBottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        detent: AppBottomSheetDetent = .medium,
        showDragIndicator: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(AppBottomSheetModifier(
            isPresented: isPresented,
            detent: detent,
            showDragIndicator: showDragIndicator,
            onDismiss: onDismiss,
            sheetContent: content
        ))
    }
}
