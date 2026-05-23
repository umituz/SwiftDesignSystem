import SwiftUI

// MARK: - Action Sheet Modifier
public struct AppActionSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String?
    let actions: [AppAction]

    public init(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        actions: [AppAction]
    ) {
        self._isPresented = isPresented
        self.title = title
        self.message = message
        self.actions = actions
    }

    public func body(content: Content) -> some View {
        content
            .confirmationDialog(
                title,
                isPresented: $isPresented,
                titleVisibility: .visible
            ) {
                ForEach(actions) { action in
                    button(for: action)
                }
            } message: {
                if let message {
                    Text(message)
                }
            }
    }

    @ViewBuilder
    private func button(for action: AppAction) -> some View {
        let role: ButtonRole? = {
            switch action.style {
            case .destructive: return .destructive
            case .cancel: return .cancel
            case .default: return nil
            }
        }()

        Button(role: role) {
            AppHaptics.light()
            action.action()
        } label: {
            Text(action.title)
        }
    }
}

// MARK: - View Extension
extension View {
    public func appActionSheet(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        actions: [AppAction]
    ) -> some View {
        self.modifier(AppActionSheetModifier(
            isPresented: isPresented,
            title: title,
            message: message,
            actions: actions
        ))
    }
}
