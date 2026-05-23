import SwiftUI

// MARK: - Tab Item
public struct AppTabItem: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let icon: String?

    public init(id: String? = nil, title: String, icon: String? = nil) {
        self.id = id ?? title
        self.title = title
        self.icon = icon
    }
}

// MARK: - AppTabs
public struct AppTabs: View {
    let items: [AppTabItem]
    @Binding var selectedIndex: Int
    let color: Color

    public init(
        items: [AppTabItem],
        selectedIndex: Binding<Int>,
        color: Color = DesignTokens.Colors.primary
    ) {
        self.items = items
        self._selectedIndex = selectedIndex
        self.color = color
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignTokens.Spacing.xs) {
                ForEach(0..<items.count, id: \.self) { index in
                    tabButton(index: index, item: items[index])
                }
            }
            .padding(.horizontal, DesignTokens.Spacing.lg)
        }
        .padding(.vertical, DesignTokens.Spacing.xs)
        .background(DesignTokens.Colors.background)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(DesignTokens.Colors.separator)
                .frame(height: DesignTokens.Border.thin)
        }
    }

    private func tabButton(index: Int, item: AppTabItem) -> some View {
        let isActive = selectedIndex == index

        return Button {
            AppHaptics.selectionChanged()
            withAnimation(DesignTokens.Animations.quick) {
                selectedIndex = index
            }
        } label: {
            HStack(spacing: DesignTokens.Spacing.xs) {
                if let icon = item.icon {
                    Image(systemName: icon)
                        .font(DesignTokens.IconTypography.small)
                        .foregroundColor(StyleResolution.iconTintColor(
                            isSelected: isActive,
                            activeColor: color
                        ))
                }

                Text(item.title)
                    .font(isActive ? DesignTokens.Typography.subheadlineBold : DesignTokens.Typography.subheadline)
                    .foregroundColor(StyleResolution.selectionForeground(
                        isSelected: isActive,
                        activeColor: color,
                        inactiveColor: DesignTokens.Colors.textSecondary
                    ))
            }
            .padding(.horizontal, DesignTokens.Spacing.md)
            .padding(.vertical, DesignTokens.Spacing.sm)
            .background(tabBackground(isActive: isActive))
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(item.title)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(StyleResolution.selectionLabel(isSelected: isActive))
    }

    private func tabBackground(isActive: Bool) -> Color {
        StyleResolution.selectionBackground(
            isSelected: isActive,
            activeColor: color.opacity(DesignTokens.Opacity.veryTransparent)
        )
    }
}
