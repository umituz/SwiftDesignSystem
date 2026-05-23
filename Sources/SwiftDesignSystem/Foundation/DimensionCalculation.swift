import SwiftUI

// MARK: - DimensionCalculation
public enum DimensionCalculation {

    public static func gridColumnCount(
        availableWidth: CGFloat,
        minItemWidth: CGFloat,
        spacing: CGFloat
    ) -> Int {
        let effectiveMin = minItemWidth + spacing
        let columns = Int(availableWidth / effectiveMin)
        return max(1, columns)
    }

    public static func cappedWidth(
        width: CGFloat,
        maxWidth: CGFloat
    ) -> CGFloat {
        min(width, maxWidth)
    }

    public static func skeletonLineWidth(
        containerWidth: CGFloat,
        ratio: CGFloat
    ) -> CGFloat {
        let clampedRatio = max(0, min(ratio, 1.0))
        return containerWidth * clampedRatio
    }

    public static func dialogMaxWidth(
        screenMaxWidth: CGFloat,
        horizontalPadding: CGFloat
    ) -> CGFloat {
        screenMaxWidth - horizontalPadding * 2
    }
}
