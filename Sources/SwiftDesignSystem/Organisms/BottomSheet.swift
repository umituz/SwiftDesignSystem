import SwiftUI

public enum BottomSheetDetent {
    case medium
    case large
}

public struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let detent: BottomSheetDetent
    let showDragIndicator: Bool
    @ViewBuilder let content: () -> Content

    public init(
        isPresented: Binding<Bool>,
        detent: BottomSheetDetent = .medium,
        showDragIndicator: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.detent = detent
        self.showDragIndicator = showDragIndicator
        self.content = content
    }

    public var body: some View {
        if isPresented {
            overlayContent
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }

    private var overlayContent: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(DesignTokens.Animations.standard) {
                        isPresented = false
                    }
                }

            VStack(spacing: 0) {
                if showDragIndicator {
                    dragIndicator
                }

                ScrollView(.vertical, showsIndicators: false) {
                    content()
                }
                .frame(maxHeight: sheetHeight)
            }
            .background(DesignTokens.Colors.background)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: DesignTokens.CornerRadius.xl,
                    topTrailingRadius: DesignTokens.CornerRadius.xl
                )
            )
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    private var dragIndicator: some View {
        Capsule()
            .fill(DesignTokens.Colors.textTertiary.opacity(0.3))
            .frame(width: 36, height: 5)
            .padding(.top, DesignTokens.Spacing.sm)
            .padding(.bottom, DesignTokens.Spacing.xs)
    }

    private var sheetHeight: CGFloat {
        switch detent {
        case .medium: return 400
        case .large: return 600
        }
    }
}
