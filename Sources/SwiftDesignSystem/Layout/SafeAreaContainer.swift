import SwiftUI

public struct SafeAreaContainer<Content: View>: View {
    let content: Content
    var edges: Edge.Set

    public init(
        edges: Edge.Set = .all,
        @ViewBuilder content: () -> Content
    ) {
        self.edges = edges
        self.content = content()
    }

    public var body: some View {
        content
            .padding(.top, edges.contains(.top) ? DesignTokens.Spacing.xs : 0)
            .padding(.bottom, edges.contains(.bottom) ? DesignTokens.Spacing.xs : 0)
    }
}
