import SwiftUI

// MARK: - Snackbar Style
public enum AppSnackbarStyle: Sendable {
    case `default`
    case success
    case warning
    case error

    var accentColor: Color {
        switch self {
        case .default: return DesignTokens.Colors.primary
        case .success: return DesignTokens.Colors.success
        case .warning: return DesignTokens.Colors.warning
        case .error: return DesignTokens.Colors.danger
        }
    }

    var iconName: String? {
        switch self {
        case .default: return nil
        case .success: return SystemStrings.ToastIcons.success
        case .warning: return SystemStrings.ToastIcons.warning
        case .error: return SystemStrings.ToastIcons.error
        }
    }
}

// MARK: - Snackbar
public struct AppSnackbar: View {
    let message: String
    let style: AppSnackbarStyle
    let actionTitle: String?
    let action: (() -> Void)?
    let isPresented: Bool
    let onDismiss: (() -> Void)?

    public init(
        message: String,
        style: AppSnackbarStyle = .default,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil,
        isPresented: Bool,
        onDismiss: (() -> Void)? = nil
    ) {
        self.message = message
        self.style = style
        self.actionTitle = actionTitle
        self.action = action
        self.isPresented = isPresented
        self.onDismiss = onDismiss
    }

    public var body: some View {
        if isPresented {
            VStack {
                Spacer()
                snackbarContent
                    .padding(.horizontal, DesignTokens.Spacing.lg)
                    .padding(.bottom, DesignTokens.Spacing.lg)
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }

    private var snackbarContent: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            if let iconName = style.iconName {
                Image(systemName: iconName)
                    .font(DesignTokens.IconTypography.medium)
                    .foregroundColor(style.accentColor)
                    .accessibilityHidden(true)
            }

            Text(message)
                .font(DesignTokens.Typography.subheadline)
                .foregroundColor(DesignTokens.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let actionTitle, let action {
                Button {
                    action()
                } label: {
                    Text(actionTitle)
                        .font(DesignTokens.Typography.subheadlineBold)
                        .foregroundColor(style.accentColor)
                }
                .accessibilityLabel(actionTitle)
                .accessibilityAddTraits(.isButton)
            }
        }
        .padding(DesignTokens.Spacing.lg)
        .background(DesignTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
        .appShadow(DesignTokens.Shadows.medium)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message)
    }
}

// MARK: - Snackbar Modifier
public struct AppSnackbarModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let style: AppSnackbarStyle
    let actionTitle: String?
    let action: (() -> Void)?
    let duration: TimeInterval

    public init(
        isPresented: Binding<Bool>,
        message: String,
        style: AppSnackbarStyle = .default,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil,
        duration: TimeInterval = 4.0
    ) {
        self._isPresented = isPresented
        self.message = message
        self.style = style
        self.actionTitle = actionTitle
        self.action = action
        self.duration = duration
    }

    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                AppSnackbar(
                    message: message,
                    style: style,
                    actionTitle: actionTitle,
                    action: action,
                    isPresented: isPresented,
                    onDismiss: { dismiss() }
                )
                .animation(DesignTokens.Animations.standard, value: isPresented)
            }
            .onChange(of: isPresented) { _, newValue in
                if newValue {
                    scheduleAutoDismiss()
                }
            }
    }

    private func scheduleAutoDismiss() {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(duration))
            guard isPresented else { return }
            dismiss()
        }
    }

    private func dismiss() {
        isPresented = false
    }
}

extension View {
    public func snackbar(
        isPresented: Binding<Bool>,
        message: String,
        style: AppSnackbarStyle = .default,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil,
        duration: TimeInterval = 4.0
    ) -> some View {
        self.modifier(AppSnackbarModifier(
            isPresented: isPresented,
            message: message,
            style: style,
            actionTitle: actionTitle,
            action: action,
            duration: duration
        ))
    }
}
