import SwiftUI

// MARK: - AdaptiveContainer
public struct AppAdaptiveContainer<Content: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        GeometryReader { _ in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    content
                }
                .frame(maxWidth: adaptiveMaxWidth)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    private var adaptiveMaxWidth: CGFloat {
        AdaptiveValue(compact: CGFloat.infinity, regular: DesignTokens.Sizing.iPadMaxWidth)
            .resolve(for: horizontalSizeClass)
    }
}
