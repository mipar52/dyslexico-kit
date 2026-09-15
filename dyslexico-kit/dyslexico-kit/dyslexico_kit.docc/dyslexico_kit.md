# ``dyslexico_kit``

Build readable SwiftUI interfaces with dyslexia-friendly typography, spacing, colors, and input components.

## Overview

DyslexicoKit provides a typography system and a smal3l set of SwiftUI views that help client apps render readable text consistently. The core integration point is ``DyslexicoTypographySettings``. Configure it once, inject it into the SwiftUI environment, and the SDK views and modifiers below that point will use the same reading preferences.

```swift
ContentView()
    .dyslexicoTypography(userTypographySettings)
```

Use ``DyslexicoText`` for display text, ``DyslexicoTextField`` for single-line input, and ``DyslexicoTextEditor`` for multiline input. If you prefer to keep your own views, apply the SDK typography with the `dyslexicoText(_:)`, `dyslexicoText(role:)`, `dyslexicoInputChrome(isFocused:hasError:)`, and `dyslexicoReadableBackground()` view modifiers.

## Configure Typography

``DyslexicoTypographySettings`` stores the user's global reading preferences:

- Font family, size, weight, and italic preference through ``DyslexicoFontSettings``
- Text and background colors through ``DyslexicoColorSettings``
- Letter and line spacing through ``DyslexicoSpacingSettings``
- Optional letter-pair highlighting through ``DyslexicoLetterHighlightOption``

Text-specific rendering is described with ``DyslexicoTextSettings``. It combines a semantic ``DyslexicoTextRole`` with optional overrides:

```swift
let titleSettings = DyslexicoTextSettings(
    role: .title,
    weightOverride: .semiBold,
    colorOverride: .navy,
    isItalic: true
)

DyslexicoText("Welcome", textSettings: titleSettings)
```

When resolving text, the SDK prefers text-specific overrides, then global typography settings, then defaults from the selected role.

## SwiftUI Views

Use ``DyslexicoText`` for display text:

```swift
DyslexicoText("Readable body text", textSettings: .body)
DyslexicoText("Welcome", textSettings: .title, alignment: .center)
```

Use ``DyslexicoTextField`` for accessible single-line input:

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

Use ``DyslexicoTextEditor`` for multiline input:

```swift
@State private var notes = ""

DyslexicoTextEditor(
    title: "Notes",
    placeholder: "Write something readable...",
    minHeight: 140,
    text: $notes
)
```

Use ``DyslexicoButton`` and ``DyslexicoLabel`` for common interface elements that follow the same typography system:

```swift
DyslexicoButton("Continue", systemImage: "arrow.right") {
    submit()
}

DyslexicoLabel("Reading mode", systemImage: "textformat")
```

## Apply Typography to Your Own Views

Client apps do not need to use the SDK views. Apply DyslexicoKit typography to native SwiftUI views with modifiers:

```swift
Text("Native SwiftUI text")
    .dyslexicoText(role: .body)

Text("Important title")
    .dyslexicoText(.init(role: .title, weightOverride: .semiBold))
```

Use the input chrome and readable background helpers when building custom controls:

```swift
TextField("Email", text: $email)
    .dyslexicoInputChrome(isFocused: isFocused, hasError: hasError)

Text("Long readable paragraph")
    .dyslexicoText(role: .body)
    .dyslexicoTextLayout(.wrap(lines: nil))
```

## UIKit Integration

The same settings can resolve UIKit fonts and colors:

```swift
label.font = typography.uiFont(for: .body)
label.textColor = typography.uiColor(for: .body)
```

## Topics

### Typography Settings

- ``DyslexicoTypographySettings``
- ``DyslexicoTextSettings``
- ``DyslexicoTextRole``
- ``DyslexicoFontSettings``
- ``DyslexicoFontFamily``
- ``DyslexicoFontWeight``
- ``DyslexicoColorSettings``
- ``LetterColor``
- ``BackgroundColor``
- ``DyslexicoSpacingSettings``
- ``DyslexicoLetterHighlightOption``

### SwiftUI Views

- ``DyslexicoText``
- ``DyslexicoTextField``
- ``DyslexicoTextEditor``
- ``DyslexicoButton``
- ``DyslexicoButtonVariant``
- ``DyslexicoLabel``
- ``DyslexicoTextLayout``

### Modifiers

- ``DyslexicoViewModifiers``
- ``DyslexicoInputChromeModifier``
- ``DyslexicoReadableBackgroundModifier``

### Font Resolution

- ``DyslexicoFontResolver``
