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
                        AppScreenHeader(
                            title: title,
                            leftIcon: headerLeftIcon,
                            leftAction: onBack
                        ) {
                            trailingContent
                        }
                        .padding(.bottom, DesignTokens.Spacing.md)
                    }

                    content()
                }
                .frame(maxWidth: contentMaxWidth(isTablet: isTablet))
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .background(DesignTokens.Colors.groupedBackground)
    }

    private var headerLeftIcon: String? {
        if showsBackButton {
            return SystemStrings.StateIcons.backNavigation
        }
        return nil
    }

    private func contentMaxWidth(isTablet: Bool) -> CGFloat {
        if isTablet {
            return DesignTokens.Sizing.iPadMaxWidth
        }
        return .infinity
    }
}
