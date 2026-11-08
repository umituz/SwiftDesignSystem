import SwiftUI

// MARK: - Button Style
public enum AppButtonStyle: Sendable {
    case primary
    case secondary
    case outline
    case ghost
}

// MARK: - AppButton
public struct AppButton: View {
    let title: String
    let icon: String?
    let style: AppButtonStyle
    let isLoading: Bool
    let isDisabled: Bool
    let action: () -> Void

    @Environment(\.appTheme) private var theme

    public init(
        _ title: String,
        icon: String? = nil,
        style: AppButtonStyle = .primary,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }

    public var body: some View {
        Button {
            AppHaptics.light()
            action()
        } label: {
            buttonContent
        }
        .disabled(isDisabled || isLoading)
        .opacity(StyleResolution.disabledOpacity(isDisabled: isDisabled || isLoading))
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Content Variants

    @ViewBuilder
    private var buttonContent: some View {
        switch style {
        case .primary:
            primaryContent
        case .secondary:
            secondaryContent
        case .outline:
            outlineContent
        case .ghost:
            ghostContent
        }
    }

    private var primaryContent: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            if isLoading {
                ProgressView()
                    .tint(theme.onAccent)
            } else {
                iconView
            }
            Text(title)
                .font(DesignTokens.Typography.bodyBold)
        }
        .frame(maxWidth: .infinity)
        .frame(height: DesignTokens.Sizing.buttonHeight)
        .background(theme.heroGradient)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius(DesignTokens.CornerRadius.lg), style: .continuous))
        .appShadow(DesignTokens.Shadows.cardTint)
    }

    private var secondaryContent: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            if isLoading {
                ProgressView()
                    .tint(theme.accentPrimary)
            } else {
                iconView
            }
            Text(title)
                .font(DesignTokens.Typography.subheadlineBold)
        }
        .padding(.horizontal, DesignTokens.Spacing.xl)
        .padding(.vertical, DesignTokens.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: theme.radius(DesignTokens.CornerRadius.lg), style: .continuous)
                .stroke(theme.accentPrimary.opacity(DesignTokens.Opacity.veryTransparent), lineWidth: DesignTokens.Border.thick)
        )
        .foregroundColor(theme.accentPrimary)
    }

    private var outlineContent: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            if isLoading {
                ProgressView()
                    .tint(theme.accentPrimary)
            } else {
                iconView
            }
            Text(title)
                .font(DesignTokens.Typography.bodyBold)
        }
        .frame(maxWidth: .infinity)
        .frame(height: DesignTokens.Sizing.buttonHeight)
        .background(
            RoundedRectangle(cornerRadius: theme.radius(DesignTokens.CornerRadius.lg), style: .continuous)
                .stroke(theme.accentPrimary.opacity(DesignTokens.Opacity.veryTransparent), lineWidth: DesignTokens.Border.thick)
        )
        .foregroundColor(theme.accentPrimary)
    }

    private var ghostContent: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            if isLoading {
                ProgressView()
                    .tint(theme.accentPrimary)
            } else {
                iconView
            }
            Text(title)
                .font(DesignTokens.Typography.body)
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .padding(.vertical, DesignTokens.Spacing.sm)
    }

    @ViewBuilder
    private var iconView: some View {
        if let icon {
            Image(systemName: icon)
                .font(DesignTokens.IconTypography.small)
        }
    }
}
