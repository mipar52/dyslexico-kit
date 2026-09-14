<h1>
  <img width="72" height="72" alt="DyslexicoKit logo" src="https://github.com/user-attachments/assets/b6acc3b2-f6d6-40ca-9e7c-7f7245f2ad55" />
  DyslexicoKit
</h1>

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

## SwiftUI Integration

Set typography once near the root of your SwiftUI view hierarchy:

```swift
ContentView()
    .dyslexicoTypography(userTypographySettings)
```

All DyslexicoKit views and text modifiers below that point will read the same settings from the SwiftUI environment.

## Text Views

Use `DyslexicoTextView` when you want text that automatically follows the active DyslexicoKit typography settings:

```swift
DyslexicoTextView("Welcome", textSettings: .title)

DyslexicoTextView(
    "Readable body text",
    textSettings: .body,
    layout: .wrap(lines: nil)
)
```

For localized strings:

```swift
DyslexicoTextView(
    "settings_title",
    textSettings: .title,
    alignment: .center
)
```

## Text Fields

Use `DyslexicoTextField` for accessible text input styled with the active typography settings:

```swift
@State private var email = ""

DyslexicoTextField(
    title: "Email",
    placeholder: "name@example.com",
    systemImage: "envelope",
    keyboardType: .emailAddress,
    textContentType: .emailAddress,
    text: $email
)
```

Secure input is supported with built-in show/hide password accessibility labels:

```swift
@State private var password = ""

DyslexicoTextField(
    title: "Password",
    placeholder: "Required",
    systemImage: "lock",
    isSecure: true,
    textContentType: .password,
    text: $password
)
```

You can customize the title, input, and error typography independently:

```swift
DyslexicoTextField(
    title: "Username",
    placeholder: "Username",
    error: "Username is required",
    titleTextSettings: .caption,
    inputTextSettings: .input,
    errorTextSettings: .init(role: .caption, colorOverride: .error),
    text: $username
)
```

## View Modifiers

If you do not want to use DyslexicoKit views, apply the typography system to your own SwiftUI views:

```swift
Text("Native SwiftUI text")
    .dyslexicoText(role: .body)

Text("Important title")
    .dyslexicoText(.init(role: .title, weightOverride: .semiBold))
```

For one-off styling with a specific settings object:

```swift
Text("Preview text")
    .dyslexicoText(.body, typography: previewTypographySettings)
```
