import SwiftUI

// MARK: - Date Picker Style
public enum AppDatePickerStyle {
    case compact
    case graphical
    case wheel
}

// MARK: - AppDatePicker
public struct AppDatePicker: View {
    let label: String?
    @Binding var date: Date
    let dateRange: ClosedRange<Date>?
    let style: AppDatePickerStyle
    let tint: Color

    public init(
        label: String? = nil,
        date: Binding<Date>,
        in dateRange: ClosedRange<Date>? = nil,
        style: AppDatePickerStyle = .compact,
        tint: Color = DesignTokens.Colors.primary
    ) {
        self.label = label
        self._date = date
        self.dateRange = dateRange
        self.style = style
        self.tint = tint
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            if let label {
                Text(label)
                    .font(DesignTokens.Typography.footnote)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
            }

            datePickerView
                .tint(tint)
        }
        .onChange(of: date) { _, _ in
            AppHaptics.selectionChanged()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? SystemStrings.Accessibility.datePicker)
    }

    @ViewBuilder
    private var datePickerView: some View {
        switch style {
        case .compact:
            makeDatePicker(style: .compact)
        case .graphical:
            makeDatePicker(style: .graphical)
        case .wheel:
            #if os(iOS)
            makeDatePicker(style: .wheel)
            #else
            makeDatePicker(style: .compact)
            #endif
        }
    }

    @ViewBuilder
    private func makeDatePicker<S: DatePickerStyle>(style: S) -> some View {
        Group {
            if let range = dateRange {
                DatePicker(selection: $date, in: range, displayedComponents: .date) {}
            } else {
                DatePicker(selection: $date, displayedComponents: .date) {}
            }
        }
        .labelsHidden()
        .datePickerStyle(style)
    }
}
