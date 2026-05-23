import SwiftUI

// MARK: - SafeAreaContainer
public struct AppSafeAreaContainer<Content: View>: View {
    let edges: Edge.Set
    let content: Content

    public init(
        edges: Edge.Set = .all,
        @ViewBuilder content: () -> Content
    ) {
        self.edges = edges
        self.content = content()
    }

    public var body: some View {
        content
            .safeAreaPadding(edges)
    }
}
