import SwiftUI
@testable import SwiftDesignSystem
import XCTest

final class ConditionalTests: XCTestCase {

    // MARK: - select

    func test_select_returnsTrueBranchWhenConditionTrue() {
        XCTAssertEqual(select(true, "on", "off"), "on")
    }

    func test_select_returnsFalseBranchWhenConditionFalse() {
        XCTAssertEqual(select(false, "on", "off"), "off")
    }

    func test_select_worksAcrossTypes() {
        XCTAssertEqual(select(1 > 2, 10.0, 20.0), 20.0)
        XCTAssertTrue(select(false, false, true))
    }

    // MARK: - View.if

    func test_view_if_appliesTransformWhenTrue() {
        let view = Color.red.if(true) { $0.opacity(0.5) }
        XCTAssertNotNil(view)
    }

    func test_view_if_skipsTransformWhenFalse() {
        let view = Color.red.if(false) { $0.opacity(0.5) }
        XCTAssertNotNil(view)
    }

    // MARK: - View.ifNotNil

    func test_view_ifNotNil_unwrapsWhenSome() {
        let value: String? = "text"
        let view = Color.blue.ifNotNil(value) { view, text in
            view.accessibilityLabel(text)
        }
        XCTAssertNotNil(view)
    }

    func test_view_ifNotNil_passesThroughWhenNil() {
        let value: String? = nil
        let view = Color.blue.ifNotNil(value) { view, text in
            view.accessibilityLabel(text)
        }
        XCTAssertNotNil(view)
    }
}
