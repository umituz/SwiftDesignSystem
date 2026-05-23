import SwiftUI

// MARK: - AppAccordion
public struct AppAccordion<Content: View>: View {
    let title: String
    let icon: String?
    @Binding var isExpanded: Bool
    let explicitTint: Color?
    @ViewBuilder let content: () -> Content

    @Environment(\.designAccentColor) private var accentColor

    public init(
        title: String,
        icon: String? = nil,
        isExpanded: Binding<Bool> = .constant(false),
        tint: Color? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.icon = icon
        self._isExpanded = isExpanded
        self.explicitTint = tint
        self.content = content
    }

    private var resolvedTint: Color {
        explicitTint ?? accentColor
    }

    public var body: some View {
        VStack(spacing: 0) {
            headerButton

            if isExpanded {
                VStack(spacing: 0) {
                    content()
                        .padding(.horizontal, DesignTokens.Spacing.lg)
                        .padding(.bottom, DesignTokens.Spacing.lg)

                    AppDivider()
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private var headerButton: some View {
        Button {
            AppHaptics.light()
            withAnimation(DesignTokens.Animations.expand) {
                isExpanded.toggle()
            }
        } label: {
            HStack(spacing: DesignTokens.Spacing.md) {
                if let icon {
                    Image(systemName: icon)
                        .font(DesignTokens.IconTypography.medium)
                        .foregroundColor(resolvedTint)
                        .accessibilityHidden(true)
                }

                Text(title)
                    .font(DesignTokens.Typography.bodyBold)
                    .foregroundColor(DesignTokens.Colors.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: StyleResolution.accordionChevron(isExpanded: isExpanded))
                    .font(DesignTokens.IconTypography.chevron)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
                    .rotationEffect(StyleResolution.accordionRotation(isExpanded: isExpanded))
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
            .frame(minHeight: DesignTokens.Sizing.accordionMinHeight)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityValue(StyleResolution.accordionLabel(isExpanded: isExpanded))
        .accessibilityAddTraits(.isButton)
    }
}
