import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - AppTextField
public struct AppTextField: View {
    let placeholder: String
    let label: String?
    let errorMessage: String?
    @Binding var text: String
    var isSecure: Bool = false

    @FocusState private var isFocused: Bool

    public init(
        _ placeholder: String,
        label: String? = nil,
        errorMessage: String? = nil,
        text: Binding<String>,
        isSecure: Bool = false
    ) {
        self.placeholder = placeholder
        self.label = label
        self.errorMessage = errorMessage
        self._text = text
        self.isSecure = isSecure
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            if let label {
                Text(label)
                    .font(DesignTokens.Typography.footnote)
                    .foregroundColor(DesignTokens.Colors.textSecondary)
                    .accessibilityHidden(true)
            }

            fieldContent
                .frame(height: DesignTokens.Sizing.textFieldHeight)
                .padding(.horizontal, DesignTokens.Spacing.lg)
                .background(
                    RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous)
                        .fill(DesignTokens.Colors.surface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md, style: .continuous)
                        .stroke(
                            errorMessage != nil ? DesignTokens.Colors.danger : DesignTokens.Colors.separator,
                            lineWidth: DesignTokens.Border.regular
                        )
                )
                .focused($isFocused)

            if let errorMessage {
                Text(errorMessage)
                    .font(DesignTokens.Typography.caption)
                    .foregroundColor(DesignTokens.Colors.danger)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? placeholder)
    }

    @ViewBuilder
    private var fieldContent: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
                .font(DesignTokens.Typography.body)
                .textContentType(.password)
        } else {
            TextField(placeholder, text: $text)
                .font(DesignTokens.Typography.body)
        }
    }
}
