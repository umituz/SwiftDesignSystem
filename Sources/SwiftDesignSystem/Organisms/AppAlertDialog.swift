import SwiftUI

// MARK: - AlertDialog
public struct AppAlertDialog: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String?
    let icon: String?
    let actions: [AppAction]

    public init(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        icon: String? = nil,
        actions: [AppAction]
    ) {
        self._isPresented = isPresented
        self.title = title
        self.message = message
        self.icon = icon
        self.actions = actions
    }

    public var body: some View {
        if isPresented {
            ZStack {
                DesignTokens.Colors.overlay
                    .ignoresSafeArea()
                    .onTapGesture {
                        if let cancelAction = actions.first(where: { $0.style == .cancel }) {
                            cancelAction.action()
                        }
                        dismiss()
                    }

                dialogContent
                    .transition(.scale(scale: 0.9).combined(with: .opacity))
            }
            .zIndex(DesignTokens.Layer.modal)
        }
    }

    private var dialogContent: some View {
        VStack(spacing: DesignTokens.Spacing.lg) {
            if let icon {
                Image(systemName: icon)
                    .font(DesignTokens.IconTypography.xLarge)
                    .foregroundColor(DesignTokens.Colors.primary)
                    .accessibilityHidden(true)
            }

            VStack(spacing: DesignTokens.Spacing.xs) {
                Text(title)
                    .font(DesignTokens.Typography.title3)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
                    .multilineTextAlignment(.center)

                if let message {
                    Text(message)
                        .font(DesignTokens.Typography.subheadline)
                        .foregroundColor(DesignTokens.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            actionButtons
        }
        .padding(DesignTokens.Spacing.xl)
        .frame(maxWidth: DimensionCalculation.dialogMaxWidth(screenMaxWidth: DesignTokens.Sizing.iPadMaxWidth, horizontalPadding: DesignTokens.Spacing.xxxl))
        .background(DesignTokens.Colors.background)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.xl, style: .continuous))
        .appShadow(DesignTokens.Shadows.strong)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
    }

    @ViewBuilder
    private var actionButtons: some View {
        if actions.count <= 2 {
            horizontalActions
        } else {
            verticalActions
        }
    }

    private var horizontalActions: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            ForEach(actions) { alertAction in
                actionButton(alertAction)
            }
        }
    }

    private var verticalActions: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            ForEach(actions) { alertAction in
                actionButton(alertAction)
            }
        }
    }

    private func actionButton(_ alertAction: AppAction) -> some View {
        Button {
            alertAction.action()
            dismiss()
        } label: {
            Text(alertAction.title)
                .font(DesignTokens.Typography.bodyBold)
                .frame(maxWidth: .infinity)
                .frame(height: DesignTokens.Sizing.buttonHeight)
                .background(actionBackground(for: alertAction))
                .foregroundColor(actionForeground(for: alertAction))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))
        }
        .accessibilityLabel(alertAction.title)
        .accessibilityAddTraits(.isButton)
        .buttonStyle(.plain)
    }

    private func actionBackground(for action: AppAction) -> Color {
        switch action.style {
        case .default: return DesignTokens.Colors.primary
        case .destructive: return DesignTokens.Colors.danger
        case .cancel: return DesignTokens.Colors.surface
        }
    }

    private func actionForeground(for action: AppAction) -> Color {
        switch action.style {
        case .default, .destructive: return DesignTokens.Colors.textOnPrimary
        case .cancel: return DesignTokens.Colors.textPrimary
        }
    }

    private func dismiss() {
        withAnimation(DesignTokens.Animations.standard) {
            isPresented = false
        }
    }

    private var accessibilityDescription: String {
        var parts = [title]
        if let message { parts.append(message) }
        return SystemStrings.joinedDescription(parts)
    }
}
