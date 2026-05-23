import SwiftUI

// MARK: - ResponsiveGrid
public struct AppResponsiveGrid<Content: View>: View {
    let minItemWidth: CGFloat
    let spacing: CGFloat
    let padding: CGFloat
    let content: () -> Content

    public init(
        minItemWidth: CGFloat = 150,
        spacing: CGFloat = DesignTokens.Spacing.md,
        padding: CGFloat = DesignTokens.Spacing.lg,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.minItemWidth = minItemWidth
        self.spacing = spacing
        self.padding = padding
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            let columns = DesignScale.gridColumns(
                availableWidth: geometry.size.width,
                minItemWidth: minItemWidth,
                spacing: spacing
            )

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
                spacing: spacing
            ) {
                content()
            }
            .padding(padding)
        }
    }
}
