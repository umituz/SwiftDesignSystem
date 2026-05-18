# SwiftDesignSystem

Atomic design principles-based SwiftUI design system for iOS 17+ apps. Provides responsive components that work on both iPhone and iPad.

## Installation

### Swift Package Manager

Add to your `project.yml`:

```yaml
packages:
  SwiftDesignSystem:
    url: https://github.com/umituz/SwiftDesignSystem
    from: 1.0.0
```

Or add directly in Xcode: `File > Add Packages > https://github.com/umituz/SwiftDesignSystem`

## Architecture

```
Foundation/     Design tokens (colors, typography, spacing, shadows, animations)
Atoms/          Smallest UI units (buttons, text fields, badges, avatars)
Molecules/      Combinations of atoms (cards, list items, chips, form fields)
Organisms/      Complex components (headers, state views, bottom sheets)
Layout/         Responsive containers (AppLayout, AdaptiveContainer, ResponsiveGrid)
Extensions/     View modifiers (cardStyle, appShadow, responsivePadding)
```

## Quick Start

```swift
import SwiftDesignSystem
```

### Design Tokens

```swift
// Colors
DesignTokens.Colors.primary
DesignTokens.Colors.success
DesignTokens.Colors.textSecondary

// Typography
DesignTokens.Typography.largeTitle
DesignTokens.Typography.headline
DesignTokens.Typography.body

// Spacing
DesignTokens.Spacing.lg   // 16
DesignTokens.Spacing.xl   // 20

// Corner Radius
DesignTokens.CornerRadius.lg   // 16
DesignTokens.CornerRadius.xl   // 20

// Shadows
DesignTokens.Shadows.subtle   // (radius: 4, y: 2)
DesignTokens.Shadows.medium   // (radius: 8, y: 4)
```

### Buttons

```swift
AppButton("Get Started", icon: "arrow.right", style: .primary) { ... }
AppButton("Cancel", style: .secondary) { ... }
AppButton("Learn More", style: .outline) { ... }
AppButton("Skip", style: .ghost) { ... }
AppButton("Loading...", isLoading: true) { ... }
```

### Cards

```swift
StatCard(icon: "flame.fill", value: "1,234", label: "Streak", style: .gradient, color: .orange)
StatCard(icon: "star", value: "42", label: "Points", style: .compact)

InfoCard(title: "Welcome", message: "Get started today", buttonTitle: "Continue") { ... }

SelectableCard(icon: "figure.run", title: "Fitness", isSelected: $isSelected) { ... }
```

### State Views

```swift
EmptyStateView(icon: "tray", title: "No Items", message: "Add your first item") { ... }
LoadingStateView(message: "Loading...")
ErrorStateView(title: "Something went wrong", buttonTitle: "Retry") { ... }
```

### Layout

```swift
AppLayout(title: "Home") {
    VStack { ... }
}

AdaptiveContainer {
    // Centers on iPad, full width on iPhone
}

ResponsiveGrid(minItemWidth: 150) {
    ForEach(items) { item in ... }
}
```

### View Modifiers

```swift
// Card styles
SomeView().cardStyle()
SomeView().primaryCardStyle()

// Shadows
SomeView().appShadow(DesignTokens.Shadows.medium)

// Responsive padding (adapts to iPad)
SomeView().responsivePadding()

// Keyboard dismissal
SomeView().hideKeyboard()

// Themed backgrounds
SomeView().themedBackground()
SomeView().groupedBackground()
```

## Responsive Design

All components adapt to screen size using `horizontalSizeClass`:

- **Compact (iPhone)**: Full width, standard padding
- **Regular (iPad)**: Max-width container (700pt), increased spacing

Grid columns calculated dynamically:
- iPhone: 2 columns
- iPad Mini: 3-4 columns
- iPad Pro: 4+ columns

## Design Tokens Reference

| Token | Values |
|-------|--------|
| Spacing | xs(4), sm(8), md(12), lg(16), xl(20), xxl(24), xxxl(32), huge(48) |
| Corner Radius | sm(8), md(12), lg(16), xl(20), xxl(24), full(999) |
| Icon Size | small(16), medium(20), large(24), xLarge(32), xxLarge(48), hero(64) |
| Shadows | subtle, medium, strong |
| Animations | quick, standard, slow, bouncy, progress, card, button |

## License

MIT
