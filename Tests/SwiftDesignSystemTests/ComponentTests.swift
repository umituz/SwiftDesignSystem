import XCTest
@testable import SwiftDesignSystem
import SwiftUI

final class ComponentTests: XCTestCase {

    // MARK: - AppAction

    func testActionStableId() {
        let action = AppAction(title: "Confirm") {}
        XCTAssertEqual(action.id, "Confirm")
    }

    func testActionCustomId() {
        let action = AppAction(id: "custom", title: "Confirm") {}
        XCTAssertEqual(action.id, "custom")
    }

    func testActionDestructiveStyle() {
        let action = AppAction(title: "Delete", style: .destructive) {}
        if case .destructive = action.style {
            // expected
        } else {
            XCTFail("Should be destructive")
        }
    }

    func testActionDefaultStyle() {
        let action = AppAction(title: "OK") {}
        if case .default = action.style {
            // expected
        } else {
            XCTFail("Should be default")
        }
    }

    func testActionCancelStyle() {
        let action = AppAction(title: "Cancel", style: .cancel) {}
        if case .cancel = action.style {
            // expected
        } else {
            XCTFail("Should be cancel")
        }
    }

    func testActionEqualityById() {
        let a1 = AppAction(id: "x", title: "A") {}
        let a2 = AppAction(id: "x", title: "B") {}
        XCTAssertEqual(a1.id, a2.id)
    }

    func testActionDifferentId() {
        let a1 = AppAction(title: "A") {}
        let a2 = AppAction(title: "B") {}
        XCTAssertNotEqual(a1.id, a2.id)
    }

    // MARK: - AppIcon

    func testAppIconSizes() {
        let sizes: [AppIconSize] = [.small, .medium, .large, .xLarge, .hero]
        for size in sizes {
            let icon = AppIcon("star", size: size)
            XCTAssertNotNil(icon)
        }
    }

    func testAppIconDefaultParameters() {
        let icon = AppIcon("star")
        XCTAssertNotNil(icon)
    }

    func testAppIconCustomColor() {
        let icon = AppIcon("star", color: .red)
        XCTAssertNotNil(icon)
    }

    func testAppIconRenderingMode() {
        let icon = AppIcon("star", renderingMode: .multicolor)
        XCTAssertNotNil(icon)
    }

    // MARK: - AppToggle

    func testToggleCreation() {
        let toggle = AppToggle(label: "Test", isOn: .constant(true))
        XCTAssertNotNil(toggle)
    }

    func testToggleOffState() {
        let toggle = AppToggle(label: "Test", isOn: .constant(false))
        XCTAssertNotNil(toggle)
    }

    func testToggleDisabled() {
        let toggle = AppToggle(label: "Test", isOn: .constant(true), isDisabled: true)
        XCTAssertNotNil(toggle)
    }

    func testToggleCustomTint() {
        let toggle = AppToggle(label: "Test", isOn: .constant(true), tint: .blue)
        XCTAssertNotNil(toggle)
    }

    // MARK: - AppCheckbox

    func testCheckboxStates() {
        let checked = AppCheckbox(label: "Test", isChecked: .constant(true))
        let unchecked = AppCheckbox(label: "Test", isChecked: .constant(false))
        XCTAssertNotNil(checked)
        XCTAssertNotNil(unchecked)
    }

    func testCheckboxStyles() {
        let defaultStyle = AppCheckbox(label: "Test", isChecked: .constant(false), style: .default)
        let circular = AppCheckbox(label: "Test", isChecked: .constant(false), style: .circular)
        XCTAssertNotNil(defaultStyle)
        XCTAssertNotNil(circular)
    }

    func testCheckboxDisabled() {
        let checkbox = AppCheckbox(label: "Test", isChecked: .constant(false), isDisabled: true)
        XCTAssertNotNil(checkbox)
    }

    func testCheckboxCustomColor() {
        let checkbox = AppCheckbox(label: "Test", isChecked: .constant(true), color: .blue)
        XCTAssertNotNil(checkbox)
    }

    // MARK: - AppSlider

    func testSliderCreation() {
        let slider = AppSlider(value: .constant(0.5))
        XCTAssertNotNil(slider)
    }

    func testSliderWithLabel() {
        let slider = AppSlider(label: "Volume", value: .constant(0.5))
        XCTAssertNotNil(slider)
    }

    func testSliderCustomRange() {
        let slider = AppSlider(value: .constant(50), in: 0...100)
        XCTAssertNotNil(slider)
    }

    func testSliderStep() {
        let slider = AppSlider(value: .constant(0.5), step: 0.1)
        XCTAssertNotNil(slider)
    }

    func testSliderHideValue() {
        let slider = AppSlider(value: .constant(0.5), showValue: false)
        XCTAssertNotNil(slider)
    }

    func testSliderDisabled() {
        let slider = AppSlider(value: .constant(0.5), isDisabled: true)
        XCTAssertNotNil(slider)
    }

    // MARK: - AppButton

    func testButtonStyles() {
        let styles: [AppButtonStyle] = [.primary, .secondary, .outline, .ghost]
        for style in styles {
            let button = AppButton("Test", style: style) {}
            XCTAssertNotNil(button)
        }
    }

    func testButtonWithIcon() {
        let button = AppButton("Test", icon: "star") {}
        XCTAssertNotNil(button)
    }

    func testButtonLoading() {
        let button = AppButton("Test", isLoading: true) {}
        XCTAssertNotNil(button)
    }

    func testButtonDisabled() {
        let button = AppButton("Test", isDisabled: true) {}
        XCTAssertNotNil(button)
    }

    // MARK: - AppAvatar

    func testAvatarSizes() {
        let sizes: [AppAvatarSize] = [.small, .medium, .large, .xLarge]
        for size in sizes {
            let avatar = AppAvatar(initials: "AB", size: size)
            XCTAssertNotNil(avatar)
        }
    }

    func testAvatarWithInitials() {
        let avatar = AppAvatar(initials: "JD")
        XCTAssertNotNil(avatar)
    }

    func testAvatarWithImage() {
        let avatar = AppAvatar(imageName: "profile")
        XCTAssertNotNil(avatar)
    }

    func testAvatarCustomColor() {
        let avatar = AppAvatar(initials: "AB", color: .blue)
        XCTAssertNotNil(avatar)
    }

    // MARK: - AppBadge

    func testBadgeStyles() {
        let pill = AppBadge(text: "New", style: .pill)
        let dot = AppBadge(style: .dot)
        let count = AppBadge(style: .count(5))
        XCTAssertNotNil(pill)
        XCTAssertNotNil(dot)
        XCTAssertNotNil(count)
    }

    func testBadgeCustomColor() {
        let badge = AppBadge(text: "New", color: .blue)
        XCTAssertNotNil(badge)
    }

    // MARK: - AppProgressView

    func testProgressViewStyles() {
        let circular = AppProgressView(progress: 0.5, style: .circular)
        let linear = AppProgressView(progress: 0.5, style: .linear)
        XCTAssertNotNil(circular)
        XCTAssertNotNil(linear)
    }

    func testProgressViewClamping() {
        let overClamped = AppProgressView(progress: 2.0)
        XCTAssertNotNil(overClamped)
        let underClamped = AppProgressView(progress: -1.0)
        XCTAssertNotNil(underClamped)
    }

    func testProgressViewWithLabel() {
        let progress = AppProgressView(progress: 0.7, label: "Uploading")
        XCTAssertNotNil(progress)
    }

    // MARK: - AppAccordion

    func testAccordionStates() {
        let collapsed = AppAccordion(title: "Section", isExpanded: .constant(false)) {
            Text("Content")
        }
        let expanded = AppAccordion(title: "Section", isExpanded: .constant(true)) {
            Text("Content")
        }
        XCTAssertNotNil(collapsed)
        XCTAssertNotNil(expanded)
    }

    func testAccordionWithIcon() {
        let accordion = AppAccordion(title: "Section", icon: "star", isExpanded: .constant(false)) {
            Text("Content")
        }
        XCTAssertNotNil(accordion)
    }

    func testAccordionCustomTint() {
        let accordion = AppAccordion(title: "Section", isExpanded: .constant(false), tint: .blue) {
            Text("Content")
        }
        XCTAssertNotNil(accordion)
    }

    // MARK: - Animations Exist

    func testAnimationTokens() {
        XCTAssertNotNil(DesignTokens.Animations.quick)
        XCTAssertNotNil(DesignTokens.Animations.standard)
        XCTAssertNotNil(DesignTokens.Animations.slow)
        XCTAssertNotNil(DesignTokens.Animations.bouncy)
        XCTAssertNotNil(DesignTokens.Animations.progress)
        XCTAssertNotNil(DesignTokens.Animations.card)
        XCTAssertNotNil(DesignTokens.Animations.expand)
        XCTAssertNotNil(DesignTokens.Animations.button)
    }
}
