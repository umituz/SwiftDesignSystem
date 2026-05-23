import SwiftUI

// MARK: - Tooltip Placement
public enum AppTooltipPlacement: Sendable {
    case top
    case bottom
    case leading
    case trailing
}

// MARK: - Tooltip
public struct AppTooltip: View {
    let text: String
    let placement: AppTooltipPlacement
    let isInverted: Bool

    public init(
        text: String,
        placement: AppTooltipPlacement = .top,
        isInverted: Bool = false
    ) {
        self.text = text
        self.placement = placement
        self.isInverted = isInverted
    }

    public var body: some View {
        Text(text)
            .font(DesignTokens.Typography.caption)
            .foregroundColor(isInverted ? DesignTokens.Colors.background : DesignTokens.Colors.textOnPrimary)
            .padding(.horizontal, DesignTokens.Spacing.md)
            .padding(.vertical, DesignTokens.Spacing.xs)
            .background(isInverted ? DesignTokens.Colors.textPrimary : DesignTokens.Colors.primary)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.sm, style: .continuous))
            .appShadow(DesignTokens.Shadows.subtle)
            .accessibilityLabel(text)
    }
}

// MARK: - Tooltip Modifier
public struct AppTooltipModifier: ViewModifier {
    @Binding var isPresented: Bool
    let text: String
    let placement: AppTooltipPlacement

    public init(
        isPresented: Binding<Bool>,
        text: String,
        placement: AppTooltipPlacement = .top
    ) {
        self._isPresented = isPresented
        self.text = text
        self.placement = placement
    }

    public func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                if isPresented {
                    AppTooltip(text: text, placement: placement)
                        .offset(alignmentOffset)
                        .transition(.opacity)
                        .zIndex(DesignTokens.Layer.tooltip)
                        .animation(DesignTokens.Animations.quick, value: isPresented)
                }
            }
    }

    private var alignment: Alignment {
        switch placement {
        case .top: return .top
        case .bottom: return .bottom
        case .leading: return .leading
        case .trailing: return .trailing
        }
    }

    private var alignmentOffset: CGSize {
        let spacing = DesignTokens.Spacing.xs
        switch placement {
        case .top: return CGSize(width: 0, height: -spacing)
        case .bottom: return CGSize(width: 0, height: spacing)
        case .leading: return CGSize(width: -spacing, height: 0)
        case .trailing: return CGSize(width: spacing, height: 0)
        }
    }
}

extension View {
    public func appTooltip(
        isPresented: Binding<Bool>,
        text: String,
        placement: AppTooltipPlacement = .top
    ) -> some View {
        self.modifier(AppTooltipModifier(
            isPresented: isPresented,
            text: text,
            placement: placement
        ))
    }
}
