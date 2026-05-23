import SwiftUI

// MARK: - Toast Style
public enum AppToastStyle {
    case success
    case warning
    case error
    case info

    var icon: String {
        switch self {
        case .success: return SystemStrings.ToastIcons.success
        case .warning: return SystemStrings.ToastIcons.warning
        case .error: return SystemStrings.ToastIcons.error
        case .info: return SystemStrings.ToastIcons.info
        }
    }

    var color: Color {
        switch self {
        case .success: return DesignTokens.Colors.success
        case .warning: return DesignTokens.Colors.warning
        case .error: return DesignTokens.Colors.danger
        case .info: return DesignTokens.Colors.info
        }
    }

    var accessibilityName: String {
        switch self {
        case .success: return SystemStrings.ToastStyleNames.success
        case .warning: return SystemStrings.ToastStyleNames.warning
        case .error: return SystemStrings.ToastStyleNames.error
        case .info: return SystemStrings.ToastStyleNames.info
        }
    }
}

// MARK: - Toast
public struct AppToast: View {
    let message: String
    let style: AppToastStyle
    let isPresented: Bool
    let onDismiss: (() -> Void)?

    public init(
        message: String,
        style: AppToastStyle = .info,
        isPresented: Bool,
        onDismiss: (() -> Void)? = nil
    ) {
        self.message = message
        self.style = style
        self.isPresented = isPresented
        self.onDismiss = onDismiss
    }

    public var body: some View {
        if isPresented {
            VStack {
                toastContent
                Spacer()
            }
            .padding(.top, DesignTokens.Spacing.xl)
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }

    private var toastContent: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            Image(systemName: style.icon)
                .font(DesignTokens.IconTypography.large)
                .foregroundColor(style.color)
                .accessibilityHidden(true)

            Text(message)
                .font(DesignTokens.Typography.subheadline)
                .foregroundColor(DesignTokens.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button {
                onDismiss?()
            } label: {
                Image(systemName: SystemStrings.StateIcons.dismiss)
                    .font(DesignTokens.IconTypography.dismiss)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
            }
            .accessibilityLabel(SystemStrings.Accessibility.dismissToast)
        }
        .padding(DesignTokens.Spacing.lg)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
        .appShadow(DesignTokens.Shadows.medium)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(style.accessibilityName): \(message)")
    }
}

// MARK: - Toast Modifier
public struct AppToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let style: AppToastStyle
    let duration: TimeInterval

    public init(
        isPresented: Binding<Bool>,
        message: String,
        style: AppToastStyle = .info,
        duration: TimeInterval = 3.0
    ) {
        self._isPresented = isPresented
        self.message = message
        self.style = style
        self.duration = duration
    }

    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                AppToast(
                    message: message,
                    style: style,
                    isPresented: isPresented,
                    onDismiss: { dismiss() }
                )
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
        withAnimation(DesignTokens.Animations.standard) {
            isPresented = false
        }
    }
}

extension View {
    public func toast(
        isPresented: Binding<Bool>,
        message: String,
        style: AppToastStyle = .info,
        duration: TimeInterval = 3.0
    ) -> some View {
        self.modifier(AppToastModifier(
            isPresented: isPresented,
            message: message,
            style: style,
            duration: duration
        ))
    }
}
