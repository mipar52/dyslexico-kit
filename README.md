<div align="center">
  <img width="200" height="200" alt="DyslexicoKit logo" src="https://github.com/user-attachments/assets/b6acc3b2-f6d6-40ca-9e7c-7f7245f2ad55" />
  <h1>DyslexicoKit</h1>
</div>

## Table of Contents

- [Typography Settings](#typography-settings)
- [Custom Colors and Highlights](#custom-colors-and-highlights)
- [SwiftUI Integration](#swiftui-integration)
- [Text Views](#text-views)
- [Text Fields](#text-fields)
- [Text Editors](#text-editors)
- [Buttons and Labels](#buttons-and-labels)
- [View Modifiers](#view-modifiers)
- [Attributed Strings](#attributed-strings)
- [PDF Generation](#pdf-generation)
- [Voice and Read Aloud](#voice-and-read-aloud)

## Typography Settings

Use `DyslexicoTypographySettings` as the main typography entry point when integrating the SDK. It stores the user's global reading preferences, such as font family, base size, colors, spacing, highlighting, and italic preference.

For simple text, ask the settings object for a font by text role:

```swift
Text("Readable title")
    .font(settings.font(for: DyslexicoTextRole.title))
    .foregroundStyle(settings.color(for: DyslexicoTextSettings.title))
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
label.font = settings.uiFont(for: DyslexicoTextRole.body)
label.textColor = settings.uiColor(for: DyslexicoTextSettings.body)
```

## Custom Colors and Highlights

Client apps can store custom text and background colors directly in `DyslexicoColorSettings`:

```swift
let colorSettings = DyslexicoColorSettings(
    fontColor: .custom(red: 0.12, green: 0.12, blue: 0.12),
    backgroundColor: .custom(red: 0.98, green: 0.95, blue: 0.88)
)
```

Letter highlighting supports built-in pairs and client-defined pairs:

```swift
let highlights: Set<DyslexicoLetterHighlightOption> = [
    .bdPair,
    .customColoredPair(
        "r",
        "n",
        firstColor: .custom(red: 1.0, green: 0.86, blue: 0.58),
        secondColor: .custom(red: 0.68, green: 0.86, blue: 1.0)
    )
]
```

Use those values when creating typography settings:

```swift
let settings = DyslexicoTypographySettings(
    fontSettings: .init(family: .openDyslexic, size: 22),
    fontHighlightOptions: highlights,
    colorSettings: colorSettings,
    spacingSettings: .init(lineSpacing: 8, letterSpacing: 1.4)
)
```

## SwiftUI Integration

Set typography once near the root of your SwiftUI view hierarchy:

```swift
ContentView()
    .dyslexicoTypography(userTypographySettings)
```

All DyslexicoKit views and text modifiers below that point will read the same settings from the SwiftUI environment.

## Text Views

Use `DyslexicoText` when you want text that automatically follows the active DyslexicoKit typography settings:

```swift
DyslexicoText("Welcome", textSettings: .title)

DyslexicoText(
    "Readable body text",
    textSettings: .body,
    layout: .wrap(lines: nil)
)
```

For localized strings:

```swift
DyslexicoText(
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

## Text Editors

Use `DyslexicoTextEditor` for multiline editable text:

```swift
@State private var notes = ""

DyslexicoTextEditor(
    title: "Notes",
    placeholder: "Write something readable...",
    minHeight: 140,
    text: $notes
)
```

Like `DyslexicoTextField`, the editor supports independent title, input, and error text settings:

```swift
DyslexicoTextEditor(
    title: "Notes",
    placeholder: "Write something readable...",
    error: "Notes cannot be empty",
    titleTextSettings: .caption,
    inputTextSettings: .body,
    errorTextSettings: .init(role: .caption, colorOverride: .error),
    text: $notes
)
```

## Buttons and Labels

Use `DyslexicoButton` for actions that follow the `.button` typography role:

```swift
DyslexicoButton("Continue", systemImage: "arrow.right") {
    submit()
}
```

Button variants are available for common UI states:

```swift
DyslexicoButton("Cancel", variant: .secondary) {}
DyslexicoButton("Delete", variant: .destructive) {}
```

Use `DyslexicoLabel` for icon and text rows:

```swift
DyslexicoLabel("Reading mode", systemImage: "textformat")
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

You can also reuse the SDK input chrome and readable background:

```swift
Text("Native view")
    .dyslexicoReadableBackground()

TextField("Email", text: $email)
    .dyslexicoInputChrome(isFocused: isFocused, hasError: hasError)
```

Text layout helpers are available separately:

```swift
Text("Long readable paragraph")
    .dyslexicoText(role: .body)
    .dyslexicoTextLayout(.wrap(lines: nil))
```

## Attributed Strings

If you need highlighted text inside your own SwiftUI view, use `DyslexicoTextUtilities` to build an `AttributedString` from the same typography settings:

```swift
let attributed = DyslexicoTextUtilities.createStyledAttributedString(
    "Readable custom text",
    with: settings,
    role: .body
)

Text(attributed)
```

For UIKit, PDF, or Core Text flows, use the `NSAttributedString` helper:

```swift
let attributed = DyslexicoTextUtilities.createStyledNSAttributedString(
    "Readable PDF text",
    bodyFont: settings.uiFont(for: DyslexicoTextRole.body),
    textColor: settings.uiColor(for: DyslexicoTextSettings.body),
    kerning: settings.spacingSettings.letterSpacing,
    lineSpacing: settings.spacingSettings.lineSpacing,
    highlightOptions: settings.fontHighlightOptions,
    includeHighlights: true
)
```

## PDF Generation

`DyslexicoPdfGenerator` creates dyslexia-friendly PDFs from client-provided typography settings. This lets each app generate PDFs for the reader's actual preferences rather than a single SDK default.

```swift
let document = DyslexicoDocument(
    documentAuthor: "Dyslexico",
    title: "Reading Notes",
    pages: [
        "First page of readable content.",
        "Second page of readable content."
    ]
)

let configuration = DyslexicoPdfConfiguration(
    pdfAuthor: "Dyslexico",
    style: .dyslexiaFriendly,
    includeLetterHighlights: true,
    pageSize: .a4
)

let result = try await DyslexicoPdfGenerator().exportToPdf(
    with: document,
    pdfConfiguration: configuration,
    typography: settings
)
```

Use `.standard` when the client needs a plain PDF export:

```swift
let plainConfiguration = DyslexicoPdfConfiguration(style: .standard)
```

## Voice and Read Aloud

Use `DyslexicoSpeechController` when a client app needs read-aloud controls without managing `AVSpeechSynthesizer` directly.

```swift
let speech = DyslexicoSpeechController(
    settings: .init(
        language: "en-US",
        rate: 0.46,
        pitchMultiplier: 1.0,
        volume: 1.0,
        prefersPremiumVoice: true
    )
)

try speech.speak("Readable text for this user.")
```

The controller publishes playback state and exposes simple controls:

```swift
speech.pause()
speech.resume()
speech.stop()
```

For reader-style interfaces, pass segments and react to the active segment:

```swift
let segments = lines.map {
    DyslexicoSpeechSegment(id: $0.id, text: $0.text)
}

speech.onSegmentStarted = { segment in
    focusedLineID = segment.id
}

speech.onWillSpeakRange = { range, segment in
    highlightedWordRange = range
    focusedLineID = segment.id
}

speech.onQueueFinished = {
    focusedLineID = nil
    highlightedWordRange = nil
}

try speech.speak(segments)
```

Clients can list Apple/system voices and store a selected voice identifier in `DyslexicoSpeechSettings`:

```swift
let englishVoices = DyslexicoSpeechController.availableVoices(for: "en-US")
let selectedVoice = englishVoices.first

let settings = DyslexicoSpeechSettings(
    language: "en-US",
    voiceIdentifier: selectedVoice?.identifier,
    rate: 0.44
)
```

If the host app already manages `AVAudioSession`, disable SDK audio-session configuration:

```swift
let settings = DyslexicoSpeechSettings(configuresAudioSession: false)
```
