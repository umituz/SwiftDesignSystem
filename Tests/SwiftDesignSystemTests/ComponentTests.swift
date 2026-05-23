import XCTest
@testable import SwiftDesignSystem
import SwiftUI

final class ComponentTests: XCTestCase {

    // MARK: - StyleResolution — New Functions

    func testCheckboxIconChecked() {
        XCTAssertEqual(
            StyleResolution.checkboxIcon(isChecked: true),
            SystemStrings.StateIcons.checkboxChecked
        )
    }

    func testCheckboxIconUnchecked() {
        XCTAssertEqual(
            StyleResolution.checkboxIcon(isChecked: false),
            SystemStrings.StateIcons.checkboxUnchecked
        )
    }

    func testCheckboxLabelChecked() {
        XCTAssertEqual(
            StyleResolution.checkboxLabel(isChecked: true),
            SystemStrings.Accessibility.checkboxChecked
        )
    }

    func testCheckboxLabelUnchecked() {
        XCTAssertEqual(
            StyleResolution.checkboxLabel(isChecked: false),
            SystemStrings.Accessibility.checkboxUnchecked
        )
    }

    func testAccordionLabelExpanded() {
        XCTAssertEqual(
            StyleResolution.accordionLabel(isExpanded: true),
            SystemStrings.Accessibility.accordionExpanded
        )
    }

    func testAccordionLabelCollapsed() {
        XCTAssertEqual(
            StyleResolution.accordionLabel(isExpanded: false),
            SystemStrings.Accessibility.accordionCollapsed
        )
    }

    func testAccordionChevronExpanded() {
        XCTAssertEqual(
            StyleResolution.accordionChevron(isExpanded: true),
            SystemStrings.StateIcons.chevronUp
        )
    }

    func testAccordionChevronCollapsed() {
        XCTAssertEqual(
            StyleResolution.accordionChevron(isExpanded: false),
            SystemStrings.StateIcons.chevronDown
        )
    }

    func testAccordionRotationExpanded() {
        let angle = StyleResolution.accordionRotation(isExpanded: true)
        XCTAssertEqual(angle.degrees, 180)
    }

    func testAccordionRotationCollapsed() {
        let angle = StyleResolution.accordionRotation(isExpanded: false)
        XCTAssertEqual(angle.degrees, 0)
    }

    // MARK: - AppIcon

    func testAppIconSizeSmall() {
        let icon = AppIcon("star", size: .small)
        XCTAssertNotNil(icon)
    }

    func testAppIconSizeMedium() {
        let icon = AppIcon("star", size: .medium)
        XCTAssertNotNil(icon)
    }

    func testAppIconSizeLarge() {
        let icon = AppIcon("star", size: .large)
        XCTAssertNotNil(icon)
    }

    func testAppIconSizeXLarge() {
        let icon = AppIcon("star", size: .xLarge)
        XCTAssertNotNil(icon)
    }

    func testAppIconSizeHero() {
        let icon = AppIcon("star", size: .hero)
        XCTAssertNotNil(icon)
    }

    func testAppIconDefaultColor() {
        let icon = AppIcon("star")
        XCTAssertNotNil(icon)
    }

    func testAppIconCustomColor() {
        let icon = AppIcon("star", color: .red)
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

    func testToggleCustomLabel() {
        let toggle = AppToggle(label: "Dark Mode", isOn: .constant(true))
        XCTAssertNotNil(toggle)
    }

    // MARK: - AppCheckbox

    func testCheckboxUncheckedState() {
        let checkbox = AppCheckbox(label: "Test", isChecked: .constant(false))
        XCTAssertNotNil(checkbox)
    }

    func testCheckboxCheckedState() {
        let checkbox = AppCheckbox(label: "Test", isChecked: .constant(true))
        XCTAssertNotNil(checkbox)
    }

    func testCheckboxDisabled() {
        let checkbox = AppCheckbox(label: "Test", isChecked: .constant(false), isDisabled: true)
        XCTAssertNotNil(checkbox)
    }

    func testCheckboxDefaultStyle() {
        let checkbox = AppCheckbox(label: "Test", isChecked: .constant(false), style: .default)
        XCTAssertNotNil(checkbox)
    }

    func testCheckboxCircularStyle() {
        let checkbox = AppCheckbox(label: "Test", isChecked: .constant(false), style: .circular)
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

    func testSliderRange() {
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

    // MARK: - AppAccordion

    func testAccordionCollapsed() {
        let accordion = AppAccordion(title: "Section", isExpanded: .constant(false)) {
            Text("Content")
        }
        XCTAssertNotNil(accordion)
    }

    func testAccordionExpanded() {
        let accordion = AppAccordion(title: "Section", isExpanded: .constant(true)) {
            Text("Content")
        }
        XCTAssertNotNil(accordion)
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

    // MARK: - AppTabs

    func testTabsCreation() {
        let tabs = AppTabs(
            items: [AppTabItem(title: "Tab 1"), AppTabItem(title: "Tab 2")],
            selectedIndex: .constant(0)
        )
        XCTAssertNotNil(tabs)
    }

    func testTabsWithIcons() {
        let tabs = AppTabs(
            items: [
                AppTabItem(title: "Home", icon: "house"),
                AppTabItem(title: "Settings", icon: "gear")
            ],
            selectedIndex: .constant(0)
        )
        XCTAssertNotNil(tabs)
    }

    func testTabItemIdentifiable() {
        let item = AppTabItem(title: "Test")
        XCTAssertEqual(item.id, "Test")
        XCTAssertNil(item.icon)
    }

    func testTabItemCustomId() {
        let item = AppTabItem(id: "custom", title: "Test")
        XCTAssertEqual(item.id, "custom")
    }

    func testTabItemEquatable() {
        let item1 = AppTabItem(id: "a", title: "Test")
        let item2 = AppTabItem(id: "a", title: "Test")
        XCTAssertEqual(item1, item2)
    }

    // MARK: - AppDatePicker

    func testDatePickerCompact() {
        let picker = AppDatePicker(date: .constant(Date()), style: .compact)
        XCTAssertNotNil(picker)
    }

    func testDatePickerGraphical() {
        let picker = AppDatePicker(date: .constant(Date()), style: .graphical)
        XCTAssertNotNil(picker)
    }

    func testDatePickerWheel() {
        let picker = AppDatePicker(date: .constant(Date()), style: .wheel)
        XCTAssertNotNil(picker)
    }

    func testDatePickerWithLabel() {
        let picker = AppDatePicker(label: "Birthday", date: .constant(Date()))
        XCTAssertNotNil(picker)
    }

    func testDatePickerWithRange() {
        let today = Date()
        let picker = AppDatePicker(
            date: .constant(today),
            in: today...Calendar.current.date(byAdding: .year, value: 1, to: today)!
        )
        XCTAssertNotNil(picker)
    }

    // MARK: - AppDropdown

    func testDropdownNoSelection() {
        let dropdown = AppDropdown(options: ["A", "B", "C"], selectedIndex: .constant(nil))
        XCTAssertNotNil(dropdown)
    }

    func testDropdownWithSelection() {
        let dropdown = AppDropdown(options: ["A", "B", "C"], selectedIndex: .constant(1))
        XCTAssertNotNil(dropdown)
    }

    func testDropdownMenuStyle() {
        let dropdown = AppDropdown(options: ["A", "B"], selectedIndex: .constant(nil), style: .menu)
        XCTAssertNotNil(dropdown)
    }

    func testDropdownSheetStyle() {
        let dropdown = AppDropdown(options: ["A", "B"], selectedIndex: .constant(nil), style: .sheet)
        XCTAssertNotNil(dropdown)
    }

    func testDropdownWithLabel() {
        let dropdown = AppDropdown(label: "Country", options: ["US", "UK"], selectedIndex: .constant(nil))
        XCTAssertNotNil(dropdown)
    }

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
        if case .destructive = action.style { } else { XCTFail("Should be destructive") }
    }

    func testActionDefaultStyle() {
        let action = AppAction(title: "OK") {}
        if case .default = action.style { } else { XCTFail("Should be default") }
    }

    func testActionCancelStyle() {
        let action = AppAction(title: "Cancel", style: .cancel) {}
        if case .cancel = action.style { } else { XCTFail("Should be cancel") }
    }

    // MARK: - AppForm

    func testFormCreation() {
        let form = AppForm {
            Text("Content")
        }
        XCTAssertNotNil(form)
    }

    func testFormWithTitle() {
        let form = AppForm(title: "Settings") {
            Text("Content")
        }
        XCTAssertNotNil(form)
    }

    // MARK: - AppFormSection

    func testFormSectionWithTitle() {
        let section = AppFormSection(title: "Account") {
            Text("Content")
        }
        XCTAssertNotNil(section)
    }

    func testFormSectionWithFooter() {
        let section = AppFormSection(title: "Account", footer: "Required fields") {
            Text("Content")
        }
        XCTAssertNotNil(section)
    }

    func testFormSectionWithoutTitle() {
        let section = AppFormSection {
            Text("Content")
        }
        XCTAssertNotNil(section)
    }

    // MARK: - AppSectionedList

    func testSectionedListCreation() {
        let list = AppSectionedList(sections: [
            AppListSectionData(title: "Section 1", items: [
                AppListItemData(title: "Item 1")
            ])
        ])
        XCTAssertNotNil(list)
    }

    func testSectionedListEmpty() {
        let list = AppSectionedList(sections: [])
        XCTAssertNotNil(list)
    }

    func testSectionedListMultipleSections() {
        let list = AppSectionedList(sections: [
            AppListSectionData(title: "A", items: [
                AppListItemData(icon: "star", title: "Item 1", subtitle: "Sub", trailing: "End")
            ]),
            AppListSectionData(title: "B", items: [
                AppListItemData(title: "Item 2")
            ])
        ])
        XCTAssertNotNil(list)
    }

    func testSectionedListWithTapHandler() {
        let list = AppSectionedList(
            sections: [
                AppListSectionData(title: "Section", items: [
                    AppListItemData(title: "Item")
                ])
            ],
            onItemTap: { _, _ in }
        )
        XCTAssertNotNil(list)
    }

    // MARK: - List Item Data

    func testListItemDataDefaults() {
        let item = AppListItemData(title: "Test")
        XCTAssertNil(item.icon)
        XCTAssertNil(item.subtitle)
        XCTAssertNil(item.trailing)
        XCTAssertEqual(item.id, "Test")
    }

    func testListItemDataFull() {
        let item = AppListItemData(icon: "star", title: "Test", subtitle: "Sub", trailing: "End")
        XCTAssertEqual(item.title, "Test")
        XCTAssertEqual(item.subtitle, "Sub")
        XCTAssertEqual(item.trailing, "End")
    }

    func testListItemDataCustomId() {
        let item = AppListItemData(id: "custom-id", title: "Test")
        XCTAssertEqual(item.id, "custom-id")
    }

    func testListSectionDataStableId() {
        let section = AppListSectionData(title: "Section", items: [])
        XCTAssertEqual(section.id, "Section")
    }

    func testListSectionDataCustomId() {
        let section = AppListSectionData(id: "custom", title: "Section", items: [])
        XCTAssertEqual(section.id, "custom")
    }

    // MARK: - Design Tokens — New Entries

    func testNewSizingTokens() {
        XCTAssertEqual(DesignTokens.Sizing.toggleHeight, 31)
        XCTAssertEqual(DesignTokens.Sizing.checkboxSize, 24)
        XCTAssertEqual(DesignTokens.Sizing.sliderTrackHeight, 4)
        XCTAssertEqual(DesignTokens.Sizing.sliderThumbSize, 28)
        XCTAssertEqual(DesignTokens.Sizing.tabHeight, 44)
        XCTAssertEqual(DesignTokens.Sizing.accordionMinHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.dropdownHeight, 48)
        XCTAssertEqual(DesignTokens.Sizing.actionSheetRowHeight, 56)
        XCTAssertEqual(DesignTokens.Sizing.formSectionSpacing, 24)
    }

    func testExpandAnimationExists() {
        let animation = DesignTokens.Animations.expand
        XCTAssertNotNil(animation)
    }

    // MARK: - SystemStrings — New Entries

    func testNewAccessibilityStrings() {
        XCTAssertFalse(SystemStrings.Accessibility.toggle.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.checkbox.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.checkboxChecked.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.checkboxUnchecked.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.slider.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.sliderValue.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.accordion.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.accordionExpanded.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.accordionCollapsed.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.dropdown.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.datePicker.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.tab.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.actionSheet.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.expand.isEmpty)
        XCTAssertFalse(SystemStrings.Accessibility.collapse.isEmpty)
    }

    func testNewStateIcons() {
        XCTAssertFalse(SystemStrings.StateIcons.checkboxChecked.isEmpty)
        XCTAssertFalse(SystemStrings.StateIcons.checkboxUnchecked.isEmpty)
        XCTAssertFalse(SystemStrings.StateIcons.chevronDown.isEmpty)
        XCTAssertFalse(SystemStrings.StateIcons.chevronUp.isEmpty)
        XCTAssertFalse(SystemStrings.StateIcons.dropdown.isEmpty)
        XCTAssertFalse(SystemStrings.StateIcons.calendar.isEmpty)
    }

    func testComponentDefaults() {
        XCTAssertFalse(SystemStrings.ComponentDefaults.selectOption.isEmpty)
        XCTAssertFalse(SystemStrings.ComponentDefaults.expand.isEmpty)
        XCTAssertFalse(SystemStrings.ComponentDefaults.collapse.isEmpty)
    }
}
