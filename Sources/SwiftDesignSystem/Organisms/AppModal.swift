import SwiftUI

// MARK: - Modal Transition
public enum AppModalTransition: Sendable {
    case slide
    case fade
    case scale
}

// MARK: - Modal Modifier
public struct AppModalModifier<ModalContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let transition: AppModalTransition
    let onDismiss: (() -> Void)?
    @ViewBuilder let modalContent: () -> ModalContent

    public init(
        isPresented: Binding<Bool>,
        transition: AppModalTransition = .slide,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder modalContent: @escaping () -> ModalContent
    ) {
        self._isPresented = isPresented
        self.transition = transition
        self.onDismiss = onDismiss
        self.modalContent = modalContent
    }

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                modalContent()
                    .transition(modalTransition)
            }
    }

    private var modalTransition: AnyTransition {
        switch transition {
        case .slide: return .move(edge: .bottom)
        case .fade: return .opacity
        case .scale: return .scale(scale: 0.95).combined(with: .opacity)
        }
    }
}

extension View {
    public func appModal<Content: View>(
        isPresented: Binding<Bool>,
        transition: AppModalTransition = .slide,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(AppModalModifier(
            isPresented: isPresented,
            transition: transition,
            onDismiss: onDismiss,
            modalContent: content
        ))
    }
}
