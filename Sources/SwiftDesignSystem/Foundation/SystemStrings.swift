import Foundation

// MARK: - SystemStrings
public enum SystemStrings {

    // MARK: - Accessibility Labels
    public enum Accessibility {
        public static let avatar = "Avatar"
        public static let avatarImage = "Avatar image"
        public static let avatarInitials = "Avatar"
        public static let badge = "Badge"
        public static let notificationIndicator = "Notification indicator"
        public static let clearSearch = "Clear search"
        public static let dismissSheet = "Dismiss sheet"
        public static let dismissToast = "Dismiss"
        public static let navigateBack = "Navigate back"
        public static let loading = "Loading"
        public static let selected = "Selected"
        public static let notSelected = "Not selected"
        public static let toggleOn = "On"
        public static let toggleOff = "Off"
        public static let toggle = "Toggle"
        public static let checkbox = "Checkbox"
        public static let checkboxChecked = "Checked"
        public static let checkboxUnchecked = "Not checked"
        public static let slider = "Slider"
        public static let sliderValue = "Slider value"
        public static let accordion = "Accordion"
        public static let accordionExpanded = "Expanded"
        public static let accordionCollapsed = "Collapsed"
        public static let dropdown = "Dropdown"
        public static let datePicker = "Date picker"
        public static let tab = "Tab"
        public static let actionSheet = "Action sheet"
        public static let expand = "Expand"
        public static let collapse = "Collapse"
        public static let form = "Form"
    }

    // MARK: - Component Defaults
    public enum Defaults {
        public static let searchPlaceholder = "Search"
        public static let retryButton = "Try Again"
    }

    // MARK: - State View Defaults
    public enum StateIcons {
        public static let emptyState = "tray"
        public static let errorState = "exclamationmark.triangle"
        public static let backNavigation = "chevron.left"
        public static let search = "magnifyingglass"
        public static let clearField = "xmark.circle.fill"
        public static let dismiss = "xmark"
        public static let selectedIndicator = "checkmark.circle.fill"
        public static let unselectedIndicator = "circle"
        public static let forwardNavigation = "chevron.right"
        public static let checkboxChecked = "checkmark.square.fill"
        public static let checkboxUnchecked = "square"
        public static let chevronDown = "chevron.down"
        public static let chevronUp = "chevron.up"
        public static let dropdown = "chevron.up.chevron.down"
        public static let calendar = "calendar"
    }

    // MARK: - Toast Icons
    public enum ToastIcons {
        public static let success = "checkmark.circle.fill"
        public static let warning = "exclamationmark.triangle.fill"
        public static let error = "xmark.circle.fill"
        public static let info = "info.circle.fill"
    }

    // MARK: - Toast Style Names
    public enum ToastStyleNames {
        public static let success = "Success"
        public static let warning = "Warning"
        public static let error = "Error"
        public static let info = "Info"
    }

    // MARK: - Component Defaults
    public enum ComponentDefaults {
        public static let selectOption = "Select..."
        public static let expand = "Expand"
        public static let collapse = "Collapse"
    }

    // MARK: - Formatted Strings
    public static func avatarWithInitials(_ initials: String) -> String {
        "\(Accessibility.avatarInitials): \(initials)"
    }

    public static func errorPrefix(_ message: String) -> String {
        "Error: \(message)"
    }

    public static func joinedDescription(_ parts: [String]) -> String {
        parts.joined(separator: ". ")
    }
}
