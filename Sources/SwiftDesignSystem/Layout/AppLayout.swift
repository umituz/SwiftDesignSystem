import SwiftUI

// MARK: - AppLayout
public struct AppLayout<Content: View, Trailing: View>: View {
    let title: String?
    let showsBackButton: Bool
    let onBack: (() -> Void)?
    let trailingContent: Trailing
    @ViewBuilder let content: () -> Content

    public init(
        title: String? = nil,
        showsBackButton: Bool = false,
        onBack: (() -> Void)? = nil,
        @ViewBuilder trailingContent: () -> Trailing = { EmptyView() },
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.showsBackButton = showsBackButton
        self.onBack = onBack
        self.trailingContent = trailingContent()
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            let isTablet = DesignTokens.Breakpoint.isTablet(width: geometry.size.width)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    if let title {
                        ScreenHeader(
                            title: title,
                            leftIcon: showsBackButton ? "chevron.left" : nil,
                            leftAction: onBack
                        )
                        .padding(.bottom, DesignTokens.Spacing.md)
                    }

                    content()
                }
                .frame(maxWidth: isTablet ? DesignTokens.Sizing.iPadMaxWidth : .infinity)
                .frame(maxWidth: .infinity)
            }
        }
        .background(DesignTokens.Colors.groupedBackground)
    }
}
