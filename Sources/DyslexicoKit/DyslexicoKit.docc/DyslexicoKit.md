# ``DyslexicoKit``

Build readable SwiftUI interfaces with dyslexia-friendly typography, spacing, colors, and input components.

## Overview

DyslexicoKit provides a typography system and a small set of SwiftUI views that help client apps render readable text consistently. The core integration point is ``DyslexicoTypographySettings``. Configure it once, inject it into the SwiftUI environment, and the SDK views and modifiers below that point will use the same reading preferences.

```swift
ContentView()
    .dyslexicoTypography(userTypographySettings)
```

Use ``DyslexicoText`` for display text, ``DyslexicoTextField`` for single-line input, and ``DyslexicoTextEditor`` for multiline input. If you prefer to keep your own views, apply the SDK typography with the `dyslexicoText(_:)`, `dyslexicoText(role:)`, `dyslexicoInputChrome(isFocused:hasError:)`, and `dyslexicoReadableBackground()` view modifiers.

The sample app demonstrates several integration scopes: app-wide typography from a global settings screen, local typography for a live preview, PDF-specific typography that starts from the app settings, and a voice read-along preview that highlights the currently spoken word.

## Configure Typography

``DyslexicoTypographySettings`` stores the user's global reading preferences:

- Font family, size, weight, and italic preference through ``DyslexicoFontSettings``
- Text and background colors through ``DyslexicoColorSettings``
- Letter and line spacing through ``DyslexicoSpacingSettings``
- Optional letter-pair highlighting through ``DyslexicoLetterHighlightOption``

Bundled DyslexicoKit fonts are registered automatically when fonts are resolved, so client apps can use the provided font families without adding extra app-level font registration.

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

You can also scope typography to one subtree instead of the entire app. This is useful for previews, PDF settings panels, and comparison screens:

```swift
VStack(alignment: .leading) {
    DyslexicoText("Preview", textSettings: .title)
    DyslexicoText("Only this preview uses previewTypography.", textSettings: .body)
}
.dyslexicoTypography(previewTypography)
```

### Custom Colors and Highlights

Use custom color cases when a client app needs to store reader-specific text or background colors:

```swift
let colorSettings = DyslexicoColorSettings(
    fontColor: .custom(red: 0.12, green: 0.12, blue: 0.12),
    backgroundColor: .custom(red: 0.98, green: 0.95, blue: 0.88)
)
```

Letter highlighting can combine built-in pairs with custom colored pairs:

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

let typography = DyslexicoTypographySettings(
    fontSettings: .init(family: .openDyslexic, size: 22),
    fontHighlightOptions: highlights,
    colorSettings: colorSettings,
    spacingSettings: .init(lineSpacing: 8, letterSpacing: 1.4)
)
```

## SwiftUI Views

Use ``DyslexicoText`` for display text. It renders through the SDK's attributed text pipeline, so configured letter highlights are visible in SwiftUI text:

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
label.font = typography.uiFont(for: DyslexicoTextRole.body)
label.textColor = typography.uiColor(for: DyslexicoTextSettings.body)
```

## Attributed Strings

Use ``DyslexicoTextUtilities`` when a client app needs to render styled text in a custom view without using ``DyslexicoText``:

```swift
let attributed = DyslexicoTextUtilities.createStyledAttributedString(
    "Readable custom text",
    with: typography,
    role: .body
)

Text(attributed)
```

For UIKit, PDF, or Core Text rendering, use the `NSAttributedString` variant:

```swift
let attributed = DyslexicoTextUtilities.createStyledNSAttributedString(
    "Readable PDF text",
    bodyFont: typography.uiFont(for: DyslexicoTextRole.body),
    textColor: typography.uiColor(for: DyslexicoTextSettings.body),
    kerning: typography.spacingSettings.letterSpacing,
    lineSpacing: typography.spacingSettings.lineSpacing,
    highlightOptions: typography.fontHighlightOptions,
    includeHighlights: true
)
```

## PDF Generation

Use ``DyslexicoPdfGenerator`` to export a readable PDF from client-provided typography settings. The generator uses the passed ``DyslexicoTypographySettings`` so client apps can create PDFs for each reader's preferences.

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
    typography: typography
)
```

PDF generation can use a different typography configuration from the live app UI. A common flow is to seed PDF settings from the reader's global typography, allow PDF-specific adjustments, and pass that configuration to the generator:

```swift
var pdfTypography = userTypographySettings

let result = try await DyslexicoPdfGenerator().exportToPdf(
    with: document,
    pdfConfiguration: configuration,
    typography: pdfTypography
)
```

## Voice and Read Aloud

Use ``DyslexicoSpeechController`` when a client app needs read-aloud controls without managing `AVSpeechSynthesizer` directly:

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

The controller publishes ``DyslexicoSpeechPlaybackState`` and supports pause, resume, and stop:

```swift
speech.pause()
speech.resume()
speech.stop()
```

For reader-style interfaces, pass ``DyslexicoSpeechSegment`` values and use callbacks to keep the UI focused on the active line or word:

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

For read-along interfaces, use ``DyslexicoSpeechController/currentSpeechRange`` or `onWillSpeakRange` to highlight the word currently being spoken:

```swift
var attributed = DyslexicoTextUtilities.createStyledAttributedString(
    text,
    with: typography,
    role: .body
)

if let range = speech.currentSpeechRange,
   let stringRange = Range(range, in: text),
   let lowerBound = AttributedString.Index(stringRange.lowerBound, within: attributed),
   let upperBound = AttributedString.Index(stringRange.upperBound, within: attributed) {
    attributed[lowerBound..<upperBound].backgroundColor = .yellow
}

Text(attributed)
```

Client apps can list Apple/system voices and store a selected voice identifier:

```swift
let englishVoices = DyslexicoSpeechController.availableVoices(for: "en-US")
let selectedVoice = englishVoices.first

let speechSettings = DyslexicoSpeechSettings(
    language: "en-US",
    voiceIdentifier: selectedVoice?.identifier,
    rate: 0.44
)
```

If the host app already manages `AVAudioSession`, disable SDK audio-session configuration:

```swift
let speechSettings = DyslexicoSpeechSettings(configuresAudioSession: false)
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
- ``DyslexicoHighlightColor``
- ``DyslexicoTextUtilities``

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

### PDF Export

- ``DyslexicoPdfGenerator``
- ``DyslexicoDocument``
- ``DyslexicoPdfDocumentResult``
- ``DyslexicoPdfConfiguration``
- ``DyslexicoExportStyle``
- ``DyslexicoPageSize``
- ``DyslexicoExportError``

### Voice

- ``DyslexicoSpeechController``
- ``DyslexicoSpeechSettings``
- ``DyslexicoSpeechSegment``
- ``DyslexicoSpeechPlaybackState``
- ``DyslexicoSpeechError``
