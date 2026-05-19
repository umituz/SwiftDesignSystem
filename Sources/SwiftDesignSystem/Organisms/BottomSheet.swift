import SwiftUI

// MARK: - Bottom Sheet Detent
public enum BottomSheetDetent {
    case medium
    case large
}

// MARK: - BottomSheet
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

    // MARK: - Overlay

    private var overlayContent: some View {
        ZStack(alignment: .bottom) {
            DesignTokens.Colors.overlay
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(DesignTokens.Animations.standard) {
                        isPresented = false
                    }
                }
                .accessibilityLabel("Dismiss sheet")
                .accessibilityAddTraits(.isButton)

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

    // MARK: - Drag Indicator

    private var dragIndicator: some View {
        Capsule()
            .fill(DesignTokens.Colors.textTertiary.opacity(DesignTokens.Opacity.transparent))
            .frame(
                width: DesignTokens.Sizing.dragIndicatorWidth,
                height: DesignTokens.Sizing.dragIndicatorHeight
            )
            .padding(.top, DesignTokens.Spacing.sm)
            .padding(.bottom, DesignTokens.Spacing.xs)
            .accessibilityHidden(true)
    }

    private var sheetHeight: CGFloat {
        switch detent {
        case .medium: return DesignTokens.Sizing.bottomSheetMediumHeight
        case .large: return DesignTokens.Sizing.bottomSheetLargeHeight
        }
    }
}
