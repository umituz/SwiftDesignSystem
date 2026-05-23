import SwiftUI

// MARK: - StyleResolution
public enum StyleResolution {

    // MARK: - Selection State

    public static func selectionBackground(
        isSelected: Bool,
        activeColor: Color
    ) -> Color {
        if isSelected { return activeColor }
        return Color.clear
    }

    public static func selectionForeground(
        isSelected: Bool,
        activeColor: Color,
        inactiveColor: Color = DesignTokens.Colors.textPrimary
    ) -> Color {
        if isSelected { return DesignTokens.Colors.textOnPrimary }
        return inactiveColor
    }

    public static func selectionBorder(
        isSelected: Bool,
        activeColor: Color,
        inactiveColor: Color = DesignTokens.Colors.separator
    ) -> Color {
        if isSelected { return activeColor }
        return inactiveColor
    }

    public static func selectionBackgroundFill(
        isSelected: Bool,
        activeColor: Color,
        inactiveColor: Color = DesignTokens.Colors.surface
    ) -> Color {
        if isSelected {
            return activeColor.opacity(DesignTokens.Opacity.nearlyInvisible)
        }
        return inactiveColor
    }

    // MARK: - Icon State

    public static func iconTintColor(
        isSelected: Bool,
        activeColor: Color,
        inactiveColor: Color = DesignTokens.Colors.textTertiary
    ) -> Color {
        if isSelected { return activeColor }
        return inactiveColor
    }

    public static func iconBackground(
        isSelected: Bool,
        activeColor: Color
    ) -> Color {
        if isSelected { return activeColor }
        return activeColor.opacity(DesignTokens.Opacity.veryTransparent)
    }

    public static func selectionIndicatorIcon(isSelected: Bool) -> String {
        if isSelected { return SystemStrings.StateIcons.selectedIndicator }
        return SystemStrings.StateIcons.unselectedIndicator
    }

    // MARK: - Border State

    public static func selectionBorderWidth(
        isSelected: Bool,
        selected: CGFloat = DesignTokens.Border.thick,
        unselected: CGFloat = DesignTokens.Border.thin
    ) -> CGFloat {
        if isSelected { return selected }
        return unselected
    }

    // MARK: - Interaction State

    public static func disabledOpacity(isDisabled: Bool) -> Double {
        if isDisabled {
            return DesignTokens.Opacity.semiTransparent
        }
        return DesignTokens.Opacity.fullyVisible
    }

    // MARK: - Error State

    public static func fieldBorderColor(hasError: Bool) -> Color {
        if hasError { return DesignTokens.Colors.danger }
        return DesignTokens.Colors.separator
    }

    // MARK: - Accessibility

    public static func selectionLabel(isSelected: Bool) -> String {
        if isSelected { return SystemStrings.Accessibility.selected }
        return SystemStrings.Accessibility.notSelected
    }

    public static func toggleLabel(isOn: Bool) -> String {
        if isOn { return SystemStrings.Accessibility.toggleOn }
        return SystemStrings.Accessibility.toggleOff
    }

    // MARK: - Checkbox

    public static func checkboxIcon(isChecked: Bool) -> String {
        if isChecked { return SystemStrings.StateIcons.checkboxChecked }
        return SystemStrings.StateIcons.checkboxUnchecked
    }

    public static func checkboxLabel(isChecked: Bool) -> String {
        if isChecked { return SystemStrings.Accessibility.checkboxChecked }
        return SystemStrings.Accessibility.checkboxUnchecked
    }

    // MARK: - Accordion

    public static func accordionLabel(isExpanded: Bool) -> String {
        if isExpanded { return SystemStrings.Accessibility.accordionExpanded }
        return SystemStrings.Accessibility.accordionCollapsed
    }

    public static func accordionChevron(isExpanded: Bool) -> String {
        if isExpanded { return SystemStrings.StateIcons.chevronUp }
        return SystemStrings.StateIcons.chevronDown
    }

    public static func accordionRotation(isExpanded: Bool) -> Angle {
        if isExpanded { return .degrees(180) }
        return .degrees(0)
    }
}
