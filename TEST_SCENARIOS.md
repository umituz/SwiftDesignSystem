# SwiftDesignSystem - Test Scenarios

## Critical Risks
1. Force unwrap on `Calendar.current.date(byAdding:)` in date picker tests — use guard in production code
2. AppRoundedCorner oversized radius — now clamped to half rect dimension
3. AppHaptics static generators — thread-safe for single-threaded SwiftUI but not for concurrent access
4. DesignTokens.Colors uses `Color(red:green:blue:)` — values are 0-1 range, verified correct

## Technical Debt
1. macOS fallback colors in DesignTokens+Colors.swift are approximate — test on macOS target if needed
2. Typography dynamic type scaling only works on UIKit platforms — macOS uses static fonts
3. AppModal uses `.sheet` instead of `.fullScreenCover` for macOS compatibility

## App Store Release Readiness Checklist
- [ ] All 159 unit tests passing
- [ ] No compiler warnings
- [ ] SwiftLint clean (`swiftlint lint`)
- [ ] Dynamic Type tested at all content sizes (XS, S, M, L, XL, XXL, XXXL, Accessibility sizes)
- [ ] Dark mode / Light mode visual verification on all components
- [ ] VoiceOver navigation tested on every component
- [ ] iPad layout verified (compact, regular, split view)
- [ ] iPhone SE (small screen) layout verified
- [ ] Right-to-left language layout verified
- [ ] Haptic feedback tested on physical device (not simulator)
- [ ] Safe area handling tested on notched and non-notched devices
- [ ] Keyboard interaction tested with text fields
- [ ] Memory leak testing with Instruments (retain cycles in closures)
- [ ] Package resolved with no transitive dependency vulnerabilities
- [ ] Minimum iOS version (17.0) verified on device

---

## Component Test Scenarios

### 1. AppButton

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| All styles | Primary/Secondary/Outline/Ghost rendering | App running | Tap each style | Correct background, text color, border | Wrong colors, missing border on outline |
| Loading state | Button shows spinner | isLoading=true | Observe button | ProgressView visible, button dimmed | Button not dimmed, no spinner |
| Disabled state | Button not interactive | isDisabled=true | Tap button | No action triggered, opacity 0.5 | Action fires, full opacity |
| Icon display | Icon + text | icon="star" set | View button | SF Symbol visible before text | Icon missing, wrong size |
| Haptic feedback | Tap vibration | Physical device | Tap button | Light haptic feedback | No haptic |

### 2. AppTextField

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Basic input | Text entry | Empty field | Type "hello" | Text appears in field | Text not captured |
| Secure mode | Password entry | isSecure=true | Type text | Bullets/dots shown | Plain text visible |
| Error state | Validation error | errorMessage set | View field | Red border, error text below | No red border, no error text |
| Label display | Field label | label="Email" | View field | Label above field | Label missing |
| Focus state | Focus ring | Tap field | Blue focus ring appears | No focus indicator |

### 3. AppToggle

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Toggle on | Switch on | isOn=false | Tap toggle | isOn becomes true | State doesn't change |
| Toggle off | Switch off | isOn=true | Tap toggle | isOn becomes false | State doesn't change |
| Disabled | No interaction | isDisabled=true | Tap toggle | No state change | State changes |
| Custom tint | Override color | tint=.blue | Toggle on | Blue tint color | Default primary color |
| Environment accent | Theme override | designAccentColor(.red) parent | Toggle on | Red tint color | Ignores environment |
| Haptic | Selection changed | Physical device | Toggle | Selection haptic | No haptic |

### 4. AppCheckbox

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Check | Select | isChecked=false | Tap | Checked icon, isOn=true | No visual change |
| Uncheck | Deselect | isChecked=true | Tap | Unchecked icon, isOn=false | No visual change |
| Circular style | Round indicator | style=.circular | Check | Filled circle with checkmark | Square indicator |
| Disabled | No interaction | isDisabled=true | Tap | No state change | State changes |
| Accessibility | VoiceOver | VO on | Navigate | "Checked/Not checked" label | No state announcement |

### 5. AppSlider

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Drag to value | Slide to 0.7 | value=0.5 | Drag thumb right | value updates to ~0.7 | Value doesn't update |
| Range bounds | Cannot exceed range | range 0...100 | Drag past max | Value capped at 100 | Value > 100 |
| Step snapping | Step increment | step=10 | Drag | Values snap to 0,10,20... | Non-snapped values |
| Disabled | No interaction | isDisabled=true | Drag | No value change | Value changes |
| Value display | Show value | showValue=true | Drag | Formatted value visible | Value hidden |
| Haptic | Step feedback | Physical device | Drag through steps | Haptic per step | No haptic |

### 6. AppIcon

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Size variants | All sizes | small/medium/large/xLarge/hero | View each | Progressively larger icons | Same size |
| Color | Custom color | color=.red | View | Red tinted icon | Default gray |
| Rendering mode | Multicolor | renderingMode=.multicolor | Use palette icon | Multicolor rendering | Monochrome |
| Accessibility | Hidden from VO | VO on | Navigate | Icon skipped | Icon announced |

### 7. AppAvatar

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Initials | No image | initials="JD" | View | "JD" on gradient circle | Empty circle |
| Image | With image | imageName="profile" | View | Image clipped to circle | No image or square |
| Size | All sizes | small/medium/large/xLarge | View each | Progressively larger | Same size |
| Accessibility | VO description | VO on | Navigate | "Avatar: JD" for initials | No announcement |

### 8. AppBadge

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Pill style | Text badge | style=.pill, text="New" | View | Rounded pill with text | Square badge |
| Dot style | Indicator | style=.dot | View | Small colored circle | No dot or large |
| Count style | Number overflow | style=.count(150) | View | "99+" displayed | "150" shown |
| Count zero | Zero count | style=.count(0) | View | "0" displayed | Empty |

### 9. AppProgressView

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Circular | Default style | progress=0.65 | View | 65% arc with "65%" text | Wrong percentage |
| Linear | Bar style | style=.linear | View | Filled bar proportional | No fill or wrong width |
| Clamping | Over 100% | progress=1.5 | View | Shows 100% | Shows >100% |
| Clamping | Under 0% | progress=-0.5 | View | Shows 0% | Shows negative |
| Animation | Value change | progress 0→1 | Animate | Smooth fill animation | Instant jump |

### 10. AppSearchField

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Type search | Enter text | Empty field | Type "query" | Text appears, magnifying glass visible | No search icon |
| Clear button | Show clear | Has text | Tap X | Text cleared, X disappears | Text not cleared |
| Clear hidden | No text | Empty field | View | No clear button visible | Clear button shown |
| Submit | On submit | Has text | Press return | onSubmit callback fires | No callback |

### 11. AppSkeleton / AppSkeletonLine

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Shimmer animation | Active skeleton | isActive=true | View | Shimmer gradient moving left to right | Static, no animation |
| Shapes | All shapes | rectangle/circle/rounded | View each | Correct shape rendered | Wrong shape |
| Deactivation | Stop shimmer | isActive toggled false | Observe | Animation stops, content visible | Animation continues |
| Line width ratio | Partial width | widthRatio=0.6 | View | Line is 60% of container width | Full width |

### 12. AppChip

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Selection | Toggle select | isSelected=false | Tap | Background fills, text turns white | No visual change |
| Deselection | Toggle deselect | isSelected=true | Tap | Background clears | Still highlighted |
| Icon display | With icon | icon="star" | View | Star icon before text | No icon |
| Haptic | Selection | Physical device | Tap | Selection haptic | No haptic |

### 13. AppStatCard

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Compact style | Horizontal layout | style=.compact | View | Icon and value side by side | Vertical stack |
| Standard style | Vertical card | style=.standard | View | Icon/value/label stacked | Wrong layout |
| Large style | Big numbers | style=.large | View | Large title font | Small font |
| Gradient style | Gradient bg | style=.gradient | View | Gradient background, white text | Solid bg, dark text |

### 14. AppSegmentedControl

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Segment select | Tap segment | Index=0 | Tap segment 2 | Index=2, segment 2 highlighted | No visual change |
| Animation | Smooth transition | Animate | Observe | Smooth slide animation | Instant switch |
| Haptic | Selection | Physical device | Tap segment | Selection haptic | No haptic |

### 15. AppTabs

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Tab select | Tap tab | Index=0 | Tap "Settings" | "Settings" highlighted, others dimmed | No visual change |
| Scroll | Many tabs | 10+ tabs | Scroll | Horizontal scroll, indicators hidden | Content clipped |
| Icons | Tab icons | icon="house" set | View | Icon appears with text | No icon |

### 16. AppAccordion

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Expand | Open section | isExpanded=false | Tap header | Content appears, chevron rotates 180 | Content not visible |
| Collapse | Close section | isExpanded=true | Tap header | Content hidden, chevron rotates back | Content still visible |
| Animation | Smooth expand | Animate | Observe | Spring animation | Instant show/hide |
| Icon display | With icon | icon="info" | View | Icon before title | No icon |

### 17. AppDropdown

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Menu select | Choose option | style=.menu | Tap dropdown, select "B" | "B" displayed in field | Still shows placeholder |
| Sheet select | Bottom sheet | style=.sheet | Tap, select from list | Value updated | Value not updated |
| Placeholder | No selection | selectedIndex=nil | View | Placeholder text in gray | Empty or error |
| Selection indicator | Checkmark | selectedIndex=1 | Open sheet | Checkmark next to selected option | No checkmark |

### 18. AppForm / AppFormSection

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Form title | With title | title="Settings" | View | Large title at top | No title |
| Section title | Uppercase header | title="Account" | View | Uppercase section header | Lowercase header |
| Section footer | Help text | footer="Required" | View | Footer text below section | No footer |
| Scroll | Long form | Many sections | Scroll | Smooth vertical scroll | Clipped content |

### 19. AppEmptyStateView

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Basic empty | No data | title="No items" | View | Icon, title centered | Misaligned |
| With message | Description | message="Add your first" | View | Subtitle below title | No subtitle |
| With button | Action button | buttonTitle="Add Item" | View | Primary button at bottom | No button |
| Accessibility | VO navigation | VO on | Navigate | Icon hidden, title+message announced | Icon announced |

### 20. AppErrorStateView

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Basic error | Error display | title="Failed" | View | Red warning icon, title | Blue icon |
| With retry | Retry button | buttonAction set | Tap "Try Again" | Action callback fires | No callback |
| With message | Description | message="Network error" | View | Error description | Description missing |

### 21. AppToast

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Auto dismiss | Timer | isPresented=true | Wait 3s | isPresented=false | Still showing after 3s |
| Manual dismiss | Tap X | isPresented=true | Tap dismiss | isPresented=false | Still showing |
| Styles | All styles | success/warning/error/info | View each | Correct icon and color | Wrong icon/color |
| Safe area | Notch device | iPhone 14 Pro | Show toast | Below status bar area | Overlaps notch |
| Animation | Entry/exit | isPresented toggled | Observe | Slide + fade animation | Instant appear |

### 22. AppAlertDialog

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Show dialog | Present | isPresented=true | View | Scale-up animation, overlay dim | No animation |
| Dismiss by overlay | Tap outside | Dialog shown | Tap dark area | Dialog dismissed | Still showing |
| Actions | Button tap | 2 actions | Tap "Confirm" | Confirm action fires, dialog closes | Action fires but dialog stays |
| Destructive action | Delete | style=.destructive | View | Red button background | Default blue |
| Cancel action | Cancel | style=.cancel | View | Surface colored button | Primary colored |

### 23. AppBottomSheet

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Medium detent | Half height | detent=.medium | Present | Sheet shows at ~half screen | Full screen |
| Large detent | Full height | detent=.large | Present | Sheet shows at full height | Half screen |
| Custom height | Specific | detent=.custom(300) | Present | Sheet at 300pt height | Wrong height |
| Drag indicator | Show/hide | showDragIndicator=true/false | View | Gray pill visible/hidden | Always visible |
| Dismiss | Swipe down | Sheet shown | Swipe down | Sheet dismissed | Cannot dismiss |

### 24. AppTooltip

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Show | Display | isPresented=true | View | Tooltip text above element | Not visible |
| Placement | All directions | top/bottom/leading/trailing | View each | Tooltip on correct side | Always top |
| Animation | Fade | Toggle isPresented | Observe | Quick fade animation | Instant appear |
| Auto hide | Timer | External timer | After duration | isPresented=false | Still showing |

### 25. AppSnackbar

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Auto dismiss | Timer | isPresented=true | Wait 4s | isPresented=false | Still showing after 4s |
| With action | Undo button | actionTitle="Undo" | Tap "Undo" | Action callback fires | No callback |
| Error style | Error snackbar | style=.error | View | Red icon, red action text | Default color |
| Position | Bottom of screen | Shown | View | Positioned at bottom, above safe area | Overlaps home indicator |

### 26. AppActionSheet

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Present | Show actions | isPresented=true | View | Native action sheet with all actions | No sheet |
| Destructive | Red action | style=.destructive | View | Red text for destructive | Default text color |
| Cancel | Cancel action | style=.cancel | View | Cancel at bottom | Mixed with other actions |

### 27. Layout Components

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| AppLayout iPad | Tablet width | iPad width 1024 | View | Content centered, max 700pt wide | Full width |
| AppLayout iPhone | Phone width | iPhone width 390 | View | Full width content | Centered/narrow |
| AppResponsiveGrid | Dynamic columns | Width 400/800 | View | 2-3 cols phone, 4-5 cols tablet | Always same columns |
| AppAdaptiveContainer | iPad max | Regular size class | View | Max width capped at 700 | Full width on iPad |

### 28. View Modifiers

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| cardStyle | Card appearance | Apply modifier | View | Rounded surface background | No background |
| primaryCardStyle | Hero card | Apply modifier | View | Gradient background + shadow | Plain background |
| glassMorphism | Blur effect | Apply modifier | View | Frosted glass effect | Solid color |
| responsivePadding | Adaptive padding | iPad/iPhone | View | Larger padding on iPad | Same padding both |
| appShadow | Custom shadow | Apply with shadow | View | Visible shadow | No shadow |
| hideKeyboard | Dismiss keyboard | Text field focused | Call hideKeyboard() | Keyboard dismissed | Keyboard stays |

### 29. Design Tokens

| Scenario | Test Name | Preconditions | Steps | Expected Result | Failure Criteria |
|----------|-----------|---------------|-------|-----------------|------------------|
| Spacing scale | All values | Reference values | Check | Monotonically increasing | Out of order |
| Colors dark mode | System colors | Dark mode | View | Correct dark mode colors | Light colors in dark |
| Typography Dynamic Type | Scaling | Large accessibility size | View | Text scales appropriately | Text clipped or tiny |
| Breakpoints | Device widths | 375/430/768/1024 | Check | Correct classification | Wrong device class |

---

## Edge Case Scenarios

| Component | Edge Case | Test Steps | Expected |
|-----------|-----------|------------|----------|
| AppButton | Empty title | Create with "" | Renders without crash |
| AppTextField | Very long text | Paste 10000 chars | No performance lag |
| AppSlider | range=0...0 (zero span) | Drag | Value stays 0, no division by zero crash |
| AppSlider | step=0 (zero step) | Drag | Value updates continuously |
| AppBadge | count=0 | Display | Shows "0" |
| AppBadge | count=-1 | Display | Shows "-1" |
| AppDropdown | Empty options array | Open | No crash, empty list |
| AppDropdown | selectedIndex out of bounds | selectedIndex=999 | Shows placeholder |
| AppProgressView | progress=NaN | Display | Clamped to 0 |
| AppRoundedCorner | Radius > rect size | Small rect | Radius clamped to half rect |
| AppSectionedList | Empty sections array | Render | Empty scroll view, no crash |
| AppAccordion | Very long content | Expand | Content scrollable |
| AppToast | Duration=0 | Show | Immediately dismissed |
| AppAlertDialog | Zero actions | Show | Dialog with no buttons |
| AppTabs | Single tab | Render | Single tab works correctly |
| AppSegmentedControl | Empty segments | Render | No crash |

---

## Accessibility Scenarios

| Component | Scenario | Test Steps | Expected |
|-----------|----------|------------|----------|
| All interactive | VoiceOver navigation | Swipe through | All elements reachable and announced |
| All buttons | Button trait | VO navigate | "Button" trait announced |
| Toggles | Value announcement | Toggle on/off | "On"/"Off" announced |
| Checkboxes | State announcement | Check/uncheck | "Checked"/"Not checked" announced |
| Sliders | Value adjustment | VO adjust | Value changes, announced |
| Progress | Value readout | VO navigate | Percentage announced |
| Empty/Error states | Combined label | VO navigate | Title + message combined |
| Toast/Snackbar | Announcement | Show toast | Content announced via label |
| Forms | Header navigation | VO jump to headers | Section titles as headers |

---

## Offline / Loading / Error State Scenarios

| State | Component | Test | Expected |
|-------|-----------|------|----------|
| Loading | AppButton | isLoading=true | Spinner replaces icon, button dimmed |
| Loading | AppSkeleton | isActive=true | Shimmer animation visible |
| Loading | AppLoadingStateView | Render | Spinner with optional message |
| Empty | AppEmptyStateView | Render | Icon + title + optional action |
| Error | AppErrorStateView | Render | Red icon + title + retry button |
| Error | AppTextField | errorMessage set | Red border + error text |
