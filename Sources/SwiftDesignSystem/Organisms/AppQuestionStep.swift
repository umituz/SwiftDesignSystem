import SwiftUI

// MARK: - App Question Step
/// Scaffold for one-question-per-step flows: onboarding, wizards, quizzes.
///
/// A step asks exactly one question. It lays out an optional back button and
/// step indicator at the top, the question content in a scrollable adaptive
/// column, and a pinned CTA (plus optional secondary "skip" action) at the
/// bottom over frosted material:
///
/// - Compact width (iPhone portrait): content spans the full width.
/// - Regular width (iPad, Plus landscape): header, content, and CTA are all
///   constrained to `DesignTokens.Sizing.iPadMaxWidth` and centered.
/// - Short heights: content vertically centers when it fits and scrolls when
///   it doesn't, so nothing is ever clipped.
/// - Keyboard: the CTA follows the keyboard and the content area scrolls with
///   `.scrollDismissesKeyboard(.interactively)`.
///
/// The scaffold draws no background of its own — place it over the app's
/// background (plain color, gradient, …) with a `ZStack`.
public struct AppQuestionStep<Content: View>: View {
    let stepIndex: Int
    let stepCount: Int
    let title: String
    let subtitle: String?
    let showsIndicator: Bool
    let onBack: (() -> Void)?
    let ctaTitle: String
    let ctaDisabled: Bool
    let onCTA: () -> Void
    let secondaryTitle: String?
    let onSecondary: (() -> Void)?
    let content: Content

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.appTheme) private var theme

    public init(
        stepIndex: Int,
        stepCount: Int,
        title: String,
        subtitle: String? = nil,
        showsIndicator: Bool = true,
        onBack: (() -> Void)? = nil,
        ctaTitle: String,
        ctaDisabled: Bool = false,
        onCTA: @escaping () -> Void,
        secondaryTitle: String? = nil,
        onSecondary: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.stepIndex = stepIndex
        self.stepCount = stepCount
        self.title = title
        self.subtitle = subtitle
        self.showsIndicator = showsIndicator
        self.onBack = onBack
        self.ctaTitle = ctaTitle
        self.ctaDisabled = ctaDisabled
        self.onCTA = onCTA
        self.secondaryTitle = secondaryTitle
        self.onSecondary = onSecondary
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            if showsIndicator {
                header
            }

            questionArea

            ctaArea
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: DesignTokens.Spacing.md) {
            if let onBack {
                backButton(action: onBack)
            }

            AppStepIndicator(stepCount: stepCount, currentStep: clampedStepIndex)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Balance the back button so the indicator stays visually anchored
            // to the leading edge instead of shifting between steps.
            if onBack != nil {
                Color.clear.frame(width: backButtonSize, height: backButtonSize)
            }
        }
        .frame(maxWidth: contentColumnWidth)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, DesignTokens.Spacing.xl)
        .padding(.top, DesignTokens.Spacing.md)
        .padding(.bottom, DesignTokens.Spacing.sm)
    }

    private func backButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(DesignTokens.IconTypography.chevron)
                .foregroundColor(theme.accentPrimary)
                .frame(width: backButtonSize, height: backButtonSize)
                .background(Circle().fill(DesignTokens.Colors.surface))
                .overlay(
                    Circle().stroke(DesignTokens.Colors.separator, lineWidth: DesignTokens.Border.regular)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(SystemStrings.Accessibility.navigateBack)
    }

    // MARK: - Question

    private var questionArea: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: DesignTokens.Spacing.lg) {
                    Text(title)
                        .font(DesignTokens.Typography.title)
                        .foregroundColor(DesignTokens.Colors.textPrimary)
                        .multilineTextAlignment(.center)

                    if let subtitle {
                        Text(subtitle)
                            .font(DesignTokens.Typography.subheadline)
                            .foregroundColor(DesignTokens.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                    }

                    content
                        .padding(.top, DesignTokens.Spacing.sm)
                }
                .frame(maxWidth: contentColumnWidth)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, DesignTokens.Spacing.xl)
                // Center the question when it fits the visible height; grow and
                // scroll when it doesn't (small devices, large Dynamic Type).
                .frame(minHeight: proxy.size.height, alignment: .center)
                .padding(.bottom, DesignTokens.Spacing.xxxl)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - CTA

    private var ctaArea: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            AppButton(
                ctaTitle,
                style: .primary,
                isDisabled: ctaDisabled,
                action: onCTA
            )

            if let secondaryTitle, let onSecondary {
                Button(action: onSecondary) {
                    Text(secondaryTitle)
                        .font(DesignTokens.Typography.footnote)
                        .foregroundColor(DesignTokens.Colors.textSecondary)
                }
                .padding(.top, DesignTokens.Spacing.xs)
            }
        }
        .frame(maxWidth: contentColumnWidth)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, DesignTokens.Spacing.xl)
        .padding(.top, DesignTokens.Spacing.md)
        .padding(.bottom, DesignTokens.Spacing.sm)
        .background(.ultraThinMaterial)
    }

    // MARK: - Layout Helpers

    private var contentColumnWidth: CGFloat {
        AdaptiveValue(
            compact: CGFloat.infinity,
            regular: DesignTokens.Sizing.iPadMaxWidth
        )
        .resolve(for: horizontalSizeClass)
    }

    private var backButtonSize: CGFloat {
        DesignTokens.Sizing.buttonHeight
    }

    private var clampedStepIndex: Int {
        min(max(stepIndex, 0), max(stepCount - 1, 0))
    }
}
