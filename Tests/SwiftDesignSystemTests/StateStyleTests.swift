import SwiftUI
import XCTest
@testable import SwiftDesignSystem

final class StateStyleTests: XCTestCase {

    // MARK: - Resolution

    func testResolvePicksActiveAndInactive() {
        let style = StateStyle(active: "a", inactive: "b")
        XCTAssertEqual(style.resolve(true), "a")
        XCTAssertEqual(style.resolve(false), "b")
    }

    func testValueSemantics() {
        let style = StateStyle(active: 1, inactive: 0)
        XCTAssertEqual(style.resolve(false), 0)
    }

    func testEquatable() {
        XCTAssertEqual(
            StateStyle(active: Color.red, inactive: Color.blue),
            StateStyle(active: Color.red, inactive: Color.blue)
        )
        XCTAssertNotEqual(
            StateStyle(active: Color.red, inactive: Color.blue),
            StateStyle(active: Color.red, inactive: Color.green)
        )
    }

    // MARK: - View Helpers

    func testViewHelpersCompileForEveryTokenKind() {
        let colorStyle = StateStyle<Color>(active: .red, inactive: .blue)
        let opacityStyle = StateStyle<Double>(active: 1, inactive: 0.5)
        let scaleStyle = StateStyle<CGFloat>(active: 1.1, inactive: 1)
        let weightStyle = StateStyle<Font.Weight>(active: .bold, inactive: .regular)

        let styled = Text("token")
            .styledForeground(true, style: colorStyle)
            .styledBackground(false, style: colorStyle)
            .styledStroke(true, style: colorStyle)
            .styledOpacity(false, style: opacityStyle)
            .styledScale(true, style: scaleStyle)
            .styledFontWeight(false, style: weightStyle)
            .styledSelectionAccessibility(true)

        XCTAssertNotNil(styled)
    }
}
