import SwiftUI

// MARK: - AppDivider
public struct AppDivider: View {
    let isFullWidth: Bool
    let color: Color
    let thickness: CGFloat

    public init(
        isFullWidth: Bool = true,
        color: Color = DesignTokens.Colors.separator,
        thickness: CGFloat = DesignTokens.Border.thin
    ) {
        self.isFullWidth = isFullWidth
        self.color = color
        self.thickness = thickness
    }

    public var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: thickness)
            .padding(.horizontal, horizontalPadding)
            .accessibilityHidden(true)
    }

    private var horizontalPadding: CGFloat {
        if isFullWidth {
            return 0
        }
        return DesignTokens.Spacing.xl
    }
}
