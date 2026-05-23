import SwiftUI

// MARK: - Form Section
public struct AppFormSection<Content: View>: View {
    let title: String?
    let footer: String?
    @ViewBuilder let content: () -> Content

    public init(
        title: String? = nil,
        footer: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.footer = footer
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            if let title {
                Text(title)
                    .font(DesignTokens.Typography.footnote)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
                    .textCase(.uppercase)
                    .padding(.horizontal, DesignTokens.Spacing.lg)
                    .accessibilityAddTraits(.isHeader)
            }

            VStack(spacing: 0) {
                content()
            }
            .background(DesignTokens.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))

            if let footer {
                Text(footer)
                    .font(DesignTokens.Typography.footnote)
                    .foregroundColor(DesignTokens.Colors.textTertiary)
                    .padding(.horizontal, DesignTokens.Spacing.lg)
            }
        }
    }
}

// MARK: - AppForm
public struct AppForm<Content: View>: View {
    let title: String?
    @ViewBuilder let content: () -> Content

    public init(
        title: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: DesignTokens.Sizing.formSectionSpacing) {
                if let title {
                    Text(title)
                        .font(DesignTokens.Typography.largeTitle)
                        .foregroundColor(DesignTokens.Colors.textPrimary)
                        .padding(.horizontal, DesignTokens.Spacing.lg)
                        .accessibilityAddTraits(.isHeader)
                }

                content()
            }
            .padding(.vertical, DesignTokens.Spacing.lg)
        }
        .background(DesignTokens.Colors.groupedBackground)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title ?? SystemStrings.Accessibility.form)
    }
}
