import SwiftUI

public struct AdaptiveContainer<Content: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    content
                }
                .frame(maxWidth: horizontalSizeClass == .regular ? DesignTokens.Sizing.iPadMaxWidth : .infinity)
                .frame(maxWidth: .infinity)
            }
        }
    }
}
