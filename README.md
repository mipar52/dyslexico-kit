# DyslexicoKit

<img width="683" height="648" alt="DyslexicoKit" src="https://github.com/user-attachments/assets/b6acc3b2-f6d6-40ca-9e7c-7f7245f2ad55" />

## Typography Settings

Use `DyslexicoTypographySettings` as the main typography entry point when integrating the SDK. It stores the user's global reading preferences, such as font family, base size, colors, spacing, highlighting, and italic preference.

For simple text, ask the settings object for a font by text role:

```swift
Text("Readable title")
    .font(settings.font(for: .title))
    .foregroundStyle(settings.color(for: .title))
```

Text roles describe the purpose of a piece of text:

```swift
.title
.body
.caption
.input
.button
```

Each role adjusts the user's base font size and default weight. For example, if the user chooses a base size of `24`, `.title` can render larger, `.caption` can render smaller, and `.body` can stay at the base size.

For more control, use `DyslexicoTextSettings`:

```swift
let titleSettings = DyslexicoTextSettings(
    role: .title,
    weightOverride: .semiBold,
    colorOverride: .navy,
    isItalic: true
)

Text("Readable title")
    .font(settings.font(for: titleSettings))
    .foregroundStyle(settings.color(for: titleSettings))
```

The SDK resolves text styling in this order:

1. Text-specific overrides from `DyslexicoTextSettings`
2. Global values from `DyslexicoTypographySettings`
3. Defaults from the selected `DyslexicoTextRole`

UIKit integrations can use the matching `UIFont` and `UIColor` helpers:

```swift
label.font = settings.uiFont(for: .body)
label.textColor = settings.uiColor(for: .body)
```
