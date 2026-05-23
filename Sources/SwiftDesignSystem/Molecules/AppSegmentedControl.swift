import SwiftUI

// MARK: - AppSegmentedControl
public struct AppSegmentedControl: View {
    let segments: [String]
    @Binding var selectedIndex: Int
    let color: Color

    public init(
        segments: [String],
        selectedIndex: Binding<Int>,
        color: Color = DesignTokens.Colors.primary
    ) {
        self.segments = segments
        self._selectedIndex = selectedIndex
        self.color = color
    }

    public var body: some View {
        HStack(spacing: DesignTokens.Spacing.xs) {
            ForEach(0..<segments.count, id: \.self) { index in
                segmentButton(index: index, title: segments[index])
            }
        }
        .padding(DesignTokens.Spacing.xs)
        .background(DesignTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
    }

    private func segmentButton(index: Int, title: String) -> some View {
        let isActive = selectedIndex == index

        return Button {
            AppHaptics.selectionChanged()
            withAnimation(DesignTokens.Animations.quick) {
                selectedIndex = index
            }
        } label: {
            Text(title)
                .font(DesignTokens.Typography.subheadlineBold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DesignTokens.Spacing.sm)
                .background(StyleResolution.selectionBackground(isSelected: isActive, activeColor: color))
                .foregroundColor(StyleResolution.selectionForeground(isSelected: isActive, activeColor: color, inactiveColor: DesignTokens.Colors.textSecondary))
                .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(StyleResolution.selectionLabel(isSelected: isActive))
    }
}
