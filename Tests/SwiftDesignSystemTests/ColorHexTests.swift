import SwiftUI
import XCTest
@testable import SwiftDesignSystem

final class ColorHexTests: XCTestCase {

    // MARK: - Init

    func testSixDigitHexParsesChannels() {
        let red = Color(hex: "FF0000")
        XCTAssertEqual(red.toHex(), "FF0000")
        XCTAssertEqual(Color(hex: "00FF00").toHex(), "00FF00")
        XCTAssertEqual(Color(hex: "FFFFFF").toHex(), "FFFFFF")
    }

    func testHexWithPrefixAndHashIsSanitized() {
        XCTAssertEqual(Color(hex: "#FF5733").toHex(), "FF5733")
    }

    func testShorthandDuplicatesDigits() {
        XCTAssertEqual(Color(hex: "F00").toHex(), "FF0000")
        XCTAssertEqual(Color(hex: "0F0").toHex(), "00FF00")
    }

    func testEightDigitHexCarriesAlpha() {
        let color = Color(hex: "80FF0000")
        XCTAssertEqual(color.toHex(), "FF0000")
    }

    func testInvalidHexFallsBackToBlack() {
        XCTAssertEqual(Color(hex: "nope").toHex(), "000000")
        XCTAssertEqual(Color(hex: "").toHex(), "000000")
    }

    // MARK: - Round Trip

    func testRoundTripThroughLiteralSRGBColors() {
        // Named colors (Color.red) are dynamic system colors and differ per
        // platform — round trips assert on literal sRGB values instead.
        XCTAssertEqual(Color(red: 1, green: 0, blue: 0).toHex(), "FF0000")
        XCTAssertEqual(Color(red: 0, green: 0, blue: 1).toHex(), "0000FF")
    }

    // MARK: - Shades

    func testLightenMovesTowardsWhite() {
        let base = Color(red: 0.5, green: 0.5, blue: 0.5)
        let lightened = base.lighten(by: 0.5)
        XCTAssertGreaterThan(brightness(lightened), brightness(base))
        XCTAssertEqual(lightened.lighten(by: 1).toHex(), "FFFFFF")
    }

    func testDarkenMovesTowardsBlack() {
        let base = Color(red: 0.5, green: 0.5, blue: 0.5)
        let darkened = base.darken(by: 0.5)
        XCTAssertLessThan(brightness(darkened), brightness(base))
        XCTAssertEqual(darkened.darken(by: 1).toHex(), "000000")
    }

    func testShadePercentagesClamp() {
        let base = Color.orange
        XCTAssertEqual(base.lighten(by: 2).toHex(), "FFFFFF")
        XCTAssertEqual(base.darken(by: -1).toHex(), base.toHex())
    }

    private func brightness(_ color: Color) -> Double {
        let hex = color.toHex()
        let value = UInt64(hex, radix: 16) ?? 0
        let red = Double((value >> 16) & 0xFF)
        let green = Double((value >> 8) & 0xFF)
        let blue = Double(value & 0xFF)
        return 0.299 * red + 0.587 * green + 0.114 * blue
    }
}
