# Changelog

All notable changes to this package are documented here.
Quality gate for every release: `swiftlint` clean + `swift build` + `swift test` green.
Consumers bind via SPM URL (`from: 1.0.0`) — releases follow strict SemVer.

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
