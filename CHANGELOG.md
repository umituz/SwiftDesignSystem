# Changelog

All notable changes to this package are documented here.
Quality gate for every release: `swiftlint` clean + `swift build` + `swift test` green.
Consumers bind via SPM URL (`from: 1.0.0`) — releases follow strict SemVer.

## [1.4.1] — 2026-11-09

### Added
- **`View.roundedCorners(_:corners:)`** — selective corner rounding for chat bubbles and flush-edge sections (`UIRectCorner` on UIKit platforms; per-corner radii via `UnevenRoundedRectangle` elsewhere).

## [1.4.0] — 2026-11-09

### Added
- **`Color(hex:)` / `Color.toHex()`** — hex-string round trip (RGB, RGBA, RRGGBB, RRGGBBAA and shorthand); invalid input resolves to black.
- **`Color.lighten(by:)` / `Color.darken(by:)`** — shade adjustment for brand palettes defined in code.
- **`StateStyle<T>`** — generic active/inactive value pair replacing scattered ternaries; `Sendable`/`Equatable` conditional conformances.
- **`View.styled*` helpers** — apply `StateStyle` tokens declaratively: foreground, background, stroke, opacity, scale, font weight, selection accessibility.

### Source
Promoted from `swift_aria_ai_character_chat` local design layer (second fleet adoption pass) — generalized, app-independent.

## [1.3.0] — 2026-11-09

### Added
- **`AppTheme.surface`** — brand card/container surface; defaults to the system surface so existing themes are unchanged.
- **`cardStyle()` is theme-aware** — renders `theme.surface`, letting apps brand cards through the theme instead of local wrapper modifiers (signature unchanged).

## [1.2.0] — 2026-11-09

### Added
- **Rounded typography scale:** `DesignTokens.RoundedTypography` — the full text scale (displayXL → caption2) in rounded design, for friendly consumer apps.
- **`AppStepIndicator`** — themed onboarding/multi-step dots (capsule for current step).
- **`View.fadeSlide(isVisible:yOffset:)`** — fade + slide transition for step reveals.
- **Animation tokens:** `Animations.pulse` (1.2s loop), `Animations.breathing` (2s loop).
- **`DesignTokens.Scale`** — standardized pulse/breathing/appear scale factors.
- **`Shadows.card`** — soft plain-black card elevation.
- **Sizing:** `avatarSmall/Medium/Large` (40/60/80), `controlHeight` (44).
- **`SystemStrings.Accessibility.stepIndicator`**.

### Source
Promoted from `swift_adhd_focus_buddy` local design layer (first fleet adoption pass) — generalized, app-independent.

## [1.1.0] — 2026-11-09

### Added
- **Theming layer:** `AppTheme` (accent palette `accentPrimary/Secondary/Tertiary`, contrast-safe `onAccent`, corner personality `AppRadiusStyle` sharp/standard/soft) with eight built-in presets: `standard`, `ocean`, `sunset`, `forest`, `royal`, `rose`, `amber`, `midnight`.
- `.appTheme(_:)` view modifier — apply once at the app root; sets the theme environment and native `.tint`.
- Derived styles: `heroGradient`, `cardGradient`, `radius(_:)` scaling.
- `AppThemeTests` (preset uniqueness, legacy-token compatibility, radius scaling, environment default, equality).

### Changed
- `AppButton` resolves accents, gradient, label color and corner radius from the active theme.
- `AppBadge`, `AppProgressView` default their color to the active theme accent; explicit `color` still wins.

### Compatibility
- Without an explicit theme, everything renders exactly as before (`.standard` mirrors the classic `DesignTokens` palette — covered by tests).

## [1.0.4] — 2026-05-23
Production-grade hardening — zero SwiftLint violations, full Sendable conformance, new organisms.

## [1.0.3] — 2026-05
SRP refactor, consolidated action types, deduplicated components.

## [1.0.2] — 2026-05
Accessibility, haptics, Dynamic Type and token hardening.

## [1.0.1] / [1.0.0] — 2026-05
Initial atomic-design release: Foundation tokens, Atoms, Molecules, Organisms, Layout, Extensions.
