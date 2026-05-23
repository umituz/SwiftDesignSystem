import XCTest
@testable import SwiftDesignSystem
import SwiftUI

final class OrganismTests: XCTestCase {

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

    func testTabItemDefaults() {
        let item = AppTabItem(title: "Test")
        XCTAssertEqual(item.id, "Test")
        XCTAssertNil(item.icon)
    }

    func testTabItemCustomId() {
        let item = AppTabItem(id: "custom", title: "Test")
        XCTAssertEqual(item.id, "custom")
    }

    func testTabItemEquality() {
        let item1 = AppTabItem(id: "a", title: "Test")
        let item2 = AppTabItem(id: "a", title: "Test")
        XCTAssertEqual(item1, item2)
    }

    func testTabItemInequality() {
        let item1 = AppTabItem(id: "a", title: "Test")
        let item2 = AppTabItem(id: "b", title: "Test")
        XCTAssertNotEqual(item1, item2)
    }

    // MARK: - AppDatePicker

    func testDatePickerStyles() {
        let compact = AppDatePicker(date: .constant(Date()), style: .compact)
        let graphical = AppDatePicker(date: .constant(Date()), style: .graphical)
        let wheel = AppDatePicker(date: .constant(Date()), style: .wheel)
        XCTAssertNotNil(compact)
        XCTAssertNotNil(graphical)
        XCTAssertNotNil(wheel)
    }

    func testDatePickerWithLabel() {
        let picker = AppDatePicker(label: "Birthday", date: .constant(Date()))
        XCTAssertNotNil(picker)
    }

    func testDatePickerWithRange() {
        let today = Date()
        let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: today) ?? today
        let picker = AppDatePicker(date: .constant(today), in: today...nextYear)
        XCTAssertNotNil(picker)
    }

    // MARK: - AppDropdown

    func testDropdownStates() {
        let unselected = AppDropdown(options: ["A", "B", "C"], selectedIndex: .constant(nil))
        let selected = AppDropdown(options: ["A", "B", "C"], selectedIndex: .constant(1))
        XCTAssertNotNil(unselected)
        XCTAssertNotNil(selected)
    }

    func testDropdownStyles() {
        let menu = AppDropdown(options: ["A", "B"], selectedIndex: .constant(nil), style: .menu)
        let sheet = AppDropdown(options: ["A", "B"], selectedIndex: .constant(nil), style: .sheet)
        XCTAssertNotNil(menu)
        XCTAssertNotNil(sheet)
    }

    func testDropdownWithLabel() {
        let dropdown = AppDropdown(label: "Country", options: ["US", "UK"], selectedIndex: .constant(nil))
        XCTAssertNotNil(dropdown)
    }

    func testDropdownEmptyOptions() {
        let dropdown = AppDropdown(options: [], selectedIndex: .constant(nil))
        XCTAssertNotNil(dropdown)
    }

    // MARK: - AppForm

    func testFormCreation() {
        let form = AppForm { Text("Content") }
        XCTAssertNotNil(form)
    }

    func testFormWithTitle() {
        let form = AppForm(title: "Settings") { Text("Content") }
        XCTAssertNotNil(form)
    }

    // MARK: - AppFormSection

    func testFormSectionWithTitle() {
        let section = AppFormSection(title: "Account") { Text("Content") }
        XCTAssertNotNil(section)
    }

    func testFormSectionWithFooter() {
        let section = AppFormSection(title: "Account", footer: "Required") { Text("Content") }
        XCTAssertNotNil(section)
    }

    func testFormSectionWithoutTitle() {
        let section = AppFormSection { Text("Content") }
        XCTAssertNotNil(section)
    }

    // MARK: - AppSectionedList

    func testSectionedListCreation() {
        let list = AppSectionedList(sections: [
            AppListSectionData(title: "Section 1", items: [AppListItemData(title: "Item 1")])
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
            AppListSectionData(title: "B", items: [AppListItemData(title: "Item 2")])
        ])
        XCTAssertNotNil(list)
    }

    func testSectionedListWithTapHandler() {
        let list = AppSectionedList(
            sections: [AppListSectionData(title: "Section", items: [AppListItemData(title: "Item")])],
            onItemTap: { _, _ in }
        )
        XCTAssertNotNil(list)
    }

    // MARK: - Data Models

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

    func testListSectionDataItems() {
        let section = AppListSectionData(title: "Section", items: [
            AppListItemData(title: "A"), AppListItemData(title: "B")
        ])
        XCTAssertEqual(section.items.count, 2)
    }

    // MARK: - State Views

    func testEmptyStateView() {
        let view = AppEmptyStateView(title: "No items")
        XCTAssertNotNil(view)
    }

    func testEmptyStateViewWithButton() {
        let view = AppEmptyStateView(title: "No items", buttonTitle: "Add", buttonAction: {})
        XCTAssertNotNil(view)
    }

    func testErrorStateView() {
        let view = AppErrorStateView(title: "Failed", buttonAction: {})
        XCTAssertNotNil(view)
    }

    func testLoadingStateView() {
        let view = AppLoadingStateView()
        XCTAssertNotNil(view)
    }

    func testLoadingStateViewWithMessage() {
        let view = AppLoadingStateView(message: "Loading data...")
        XCTAssertNotNil(view)
    }

    // MARK: - Tooltip

    func testTooltipCreation() {
        let tooltip = AppTooltip(text: "Helpful tip")
        XCTAssertNotNil(tooltip)
    }

    func testTooltipPlacements() {
        for placement in [AppTooltipPlacement.top, .bottom, .leading, .trailing] {
            let tooltip = AppTooltip(text: "Tip", placement: placement)
            XCTAssertNotNil(tooltip)
        }
    }

    // MARK: - Snackbar

    func testSnackbarCreation() {
        let snackbar = AppSnackbar(message: "Item saved", isPresented: true)
        XCTAssertNotNil(snackbar)
    }

    func testSnackbarWithAction() {
        let snackbar = AppSnackbar(message: "Deleted", actionTitle: "Undo", action: {}, isPresented: true)
        XCTAssertNotNil(snackbar)
    }

    func testSnackbarStyles() {
        for style in [AppSnackbarStyle.default, .success, .warning, .error] {
            let snackbar = AppSnackbar(message: "Test", style: style, isPresented: true)
            XCTAssertNotNil(snackbar)
        }
    }
}
