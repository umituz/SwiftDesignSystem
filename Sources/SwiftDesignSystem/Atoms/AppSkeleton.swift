import SwiftUI

// MARK: - Skeleton Shape
public enum AppSkeletonShape: Sendable {
    case rectangle
    case circle
    case rounded(CGFloat)
}

// MARK: - Skeleton
public struct AppSkeleton: View {
    let width: CGFloat?
    let height: CGFloat?
    let shape: AppSkeletonShape
    let isActive: Bool

    public init(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        shape: AppSkeletonShape = .rounded(DesignTokens.CornerRadius.md),
        isActive: Bool = true
    ) {
        self.width = width
        self.height = height
        self.shape = shape
        self.isActive = isActive
    }

    public var body: some View {
        skeletonShape
            .frame(width: width, height: height)
            .foregroundColor(DesignTokens.Colors.surfaceElevated)
            .shimmer(isActive: isActive)
            .accessibilityHidden(true)
    }

    @ViewBuilder
    private var skeletonShape: some View {
        switch shape {
        case .rectangle:
            Rectangle()
        case .circle:
            Circle()
        case .rounded(let radius):
            RoundedRectangle(cornerRadius: radius, style: .continuous)
        }
    }
}

// MARK: - Skeleton Line
public struct AppSkeletonLine: View {
    let widthRatio: CGFloat
    let isActive: Bool

    public init(
        widthRatio: CGFloat = 1.0,
        isActive: Bool = true
    ) {
        self.widthRatio = widthRatio
        self.isActive = isActive
    }

    public var body: some View {
        GeometryReader { geometry in
            let lineWidth = DimensionCalculation.skeletonLineWidth(
                containerWidth: geometry.size.width,
                ratio: widthRatio
            )
            AppSkeleton(
                width: lineWidth,
                height: DesignTokens.Spacing.md,
                shape: .rounded(DesignTokens.CornerRadius.sm),
                isActive: isActive
            )
        }
        .frame(height: DesignTokens.Spacing.md)
    }
}
