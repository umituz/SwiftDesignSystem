import SwiftUI

// MARK: - Rounded Corner Shape
public struct AppRoundedCorner: Shape {
    public let topLeft: CGFloat
    public let topRight: CGFloat
    public let bottomLeft: CGFloat
    public let bottomRight: CGFloat

    public init(
        topLeft: CGFloat = 0,
        topRight: CGFloat = 0,
        bottomLeft: CGFloat = 0,
        bottomRight: CGFloat = 0
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        let tl = min(topLeft, width / 2, height / 2)
        let tr = min(topRight, width / 2, height / 2)
        let bl = min(bottomLeft, width / 2, height / 2)
        let br = min(bottomRight, width / 2, height / 2)

        path.move(to: CGPoint(x: tl, y: 0))

        path.addLine(to: CGPoint(x: width - tr, y: 0))
        path.addArc(
            center: CGPoint(x: width - tr, y: tr),
            radius: tr,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )

        path.addLine(to: CGPoint(x: width, y: height - br))
        path.addArc(
            center: CGPoint(x: width - br, y: height - br),
            radius: br,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )

        path.addLine(to: CGPoint(x: bl, y: height))
        path.addArc(
            center: CGPoint(x: bl, y: height - bl),
            radius: bl,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(
            center: CGPoint(x: tl, y: tl),
            radius: tl,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )

        path.closeSubpath()
        return path
    }
}

// MARK: - Per-Corner Radius
extension View {
    public func cornerRadius(
        _ topLeft: CGFloat,
        _ topRight: CGFloat,
        _ bottomLeft: CGFloat,
        _ bottomRight: CGFloat
    ) -> some View {
        clipShape(AppRoundedCorner(
            topLeft: topLeft,
            topRight: topRight,
            bottomLeft: bottomLeft,
            bottomRight: bottomRight
        ))
    }
}
