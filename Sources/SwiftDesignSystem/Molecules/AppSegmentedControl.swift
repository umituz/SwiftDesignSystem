import SwiftUI

// MARK: - AppSegmentedControl
public struct AppSegmentedControl: View {
    let segments: [String]
    @Binding var selectedIndex: Int
    let explicitColor: Color?

    @Environment(\.designAccentColor) private var accentColor

    public init(
        segments: [String],
        selectedIndex: Binding<Int>,
        color: Color? = nil
    ) {
        self.segments = segments
        self._selectedIndex = selectedIndex
        self.explicitColor = color
    }

    private var resolvedColor: Color {
        explicitColor ?? accentColor
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
                .background(segmentBackground(isActive: isActive))
                .foregroundColor(segmentForeground(isActive: isActive))
                .clipShape(segmentClipShape)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(StyleResolution.selectionLabel(isSelected: isActive))
    }

    private func segmentBackground(isActive: Bool) -> Color {
        StyleResolution.selectionBackground(isSelected: isActive, activeColor: resolvedColor)
    }

    private func segmentForeground(isActive: Bool) -> Color {
        StyleResolution.selectionForeground(
            isSelected: isActive,
            activeColor: resolvedColor,
            inactiveColor: DesignTokens.Colors.textSecondary
        )
    }

    private var segmentClipShape: some Shape {
        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous)
    }
}
