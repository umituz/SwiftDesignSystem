import SwiftUI

// MARK: - Dropdown Style
public enum AppDropdownStyle: Sendable {
    case menu
    case sheet
}

// MARK: - AppDropdown
public struct AppDropdown: View {
    let label: String?
    let placeholder: String
    let options: [String]
    @Binding var selectedIndex: Int?
    let style: AppDropdownStyle
    let explicitTint: Color?

    @Environment(\.designAccentColor) private var accentColor
    @State private var showSheet = false

    public init(
        label: String? = nil,
        placeholder: String = SystemStrings.ComponentDefaults.selectOption,
        options: [String],
        selectedIndex: Binding<Int?>,
        style: AppDropdownStyle = .menu,
        tint: Color? = nil
    ) {
        self.label = label
        self.placeholder = placeholder
        self.options = options
        self._selectedIndex = selectedIndex
        self.style = style
        self.explicitTint = tint
    }

    private var resolvedTint: Color {
        explicitTint ?? accentColor
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            if let label {
                Text(label)
                    .font(DesignTokens.Typography.footnote)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
            }

            if style == .menu {
                menuContent
            } else {
                sheetContent
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? SystemStrings.Accessibility.dropdown)
        .accessibilityValue(selectedOptionLabel)
    }

    private var menuContent: some View {
        Menu {
            ForEach(0..<options.count, id: \.self) { index in
                Button {
                    AppHaptics.selectionChanged()
                    selectedIndex = index
                } label: {
                    Text(options[index])
                }
            }
        } label: {
            dropdownField
        }
    }

    private var sheetContent: some View {
        Button {
            showSheet = true
        } label: {
            dropdownField
        }
        .buttonStyle(.plain)
        .appBottomSheet(isPresented: $showSheet, detent: .medium) {
            sheetList
        }
    }

    private var dropdownField: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            Text(displayText)
                .font(DesignTokens.Typography.body)
                .foregroundColor(displayColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: SystemStrings.StateIcons.dropdown)
                .font(DesignTokens.IconTypography.small)
                .foregroundColor(DesignTokens.Colors.textTertiary)
        }
        .padding(.horizontal, DesignTokens.Spacing.lg)
        .frame(height: DesignTokens.Sizing.dropdownHeight)
        .background(DesignTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous)
                .stroke(DesignTokens.Colors.separator, lineWidth: DesignTokens.Border.regular)
        )
    }

    private var sheetList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<options.count, id: \.self) { index in
                    Button {
                        AppHaptics.selectionChanged()
                        selectedIndex = index
                        showSheet = false
                    } label: {
                        HStack {
                            Text(options[index])
                                .font(DesignTokens.Typography.body)
                                .foregroundColor(DesignTokens.Colors.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if selectedIndex == index {
                                Image(systemName: SystemStrings.StateIcons.selectedIndicator)
                                    .font(DesignTokens.IconTypography.medium)
                                    .foregroundColor(resolvedTint)
                            }
                        }
                        .padding(.horizontal, DesignTokens.Spacing.lg)
                        .frame(minHeight: DesignTokens.Sizing.actionSheetRowHeight)
                    }
                    .buttonStyle(.plain)

                    if index < options.count - 1 {
                        AppDivider()
                    }
                }
            }
        }
        .padding(.top, DesignTokens.Spacing.lg)
    }

    private var displayText: String {
        if let selectedIndex, options.indices.contains(selectedIndex) {
            return options[selectedIndex]
        }
        return placeholder
    }

    private var displayColor: Color {
        if selectedIndex != nil {
            return DesignTokens.Colors.textPrimary
        }
        return DesignTokens.Colors.textTertiary
    }

    private var selectedOptionLabel: String {
        if let selectedIndex, options.indices.contains(selectedIndex) {
            return options[selectedIndex]
        }
        return placeholder
    }
}
