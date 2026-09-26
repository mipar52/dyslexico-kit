<div align="center">
  <img width="200" height="200" alt="DyslexicoKit logo" src="https://github.com/user-attachments/assets/b6acc3b2-f6d6-40ca-9e7c-7f7245f2ad55" />
  <h1>DyslexicoKit</h1>
</div>

DyslexicoKit is a Swift Package for building dyslexia-friendly reading experiences on iOS. It gives client apps a shared way to resolve readable typography, colors, spacing, letter highlights, SwiftUI views, view modifiers, attributed strings, PDF export, and text-to-speech support from one set of reader preferences.

DyslexicoKit was created as part of a computer science thesis on adapting digital and scanned text for readers with dyslexia. It is intended as an integration toolkit, not a diagnostic tool. Because reading preferences differ between users, the SDK is built around configurable settings instead of a single fixed "dyslexic" preset.

## Table of Contents

- [Research Background](#research-background)
- [Quick Start](#quick-start)
    - [Integration](#integration)
    - [Sample App Testing](#sample-app-testing)
- [Typography](#typography)
    - [Typography Settings](#typography-settings)
    - [Custom Colors and Highlights](#custom-colors-and-highlights)
- [Custom Views](#custom-views)
    - [SwiftUI Integration](#swiftui-integration)
    - [Text Views](#text-views)
    - [Text Fields](#text-fields)
    - [Text Editors](#text-editors)
    - [Buttons and Labels](#buttons-and-labels)
    - [View Modifiers](#view-modifiers)
    - [Attributed Strings](#attributed-strings)
- [PDF Generation](#pdf-generation)
- [Voice and Read Aloud](#voice-and-read-aloud)

## Research Background

DyslexicoKit is informed by research on dyslexia, readable visual design, assistive technology, document processing, and text-to-speech workflows. These references are useful for client teams that want to understand why the SDK exposes customizable typography, color pairs, highlighting, PDF, and voice settings instead of enforcing one universal reading configuration.

### Dyslexia, reading, and typography

- Lenček, Blaži, and Ivšac, [Specifične teškoće učenja: osvrt na probleme u jeziku, čitanju i pisanju](https://hrcak.srce.hr/21162)
- Döhla and Heim, [Developmental Dyslexia and Dysgraphia: What Can We Learn from the One About the Other?](https://doi.org/10.3389/fpsyg.2015.02045)
- Lenček, [Procjena disleksije u hrvatskome: neke značajke čitanja i pisanja odraslih](https://hrcak.srce.hr/79016)
- Čagalj, Šimleša, and Ivšac Pavliša, [Utjecaj fonta na čitanje osoba s disleksijom](https://doi.org/10.31299/log.6.1.1)
- Beacham and Alty, [An investigation into the effects that digital media can have on the learning outcomes of individuals who have dyslexia](https://doi.org/10.1016/j.compedu.2004.10.006)
- Yoliando, [A Comparative Study of Dyslexia Style Guides in Improving Readability for People with Dyslexia](https://doi.org/10.2991/assehr.k.201202.050)
- Elma, Rachmawanti, and Machfiroh, [Visual Design Elements for Dyslexia-Friendly Reading Materials: A Systematic Literature Review](https://doi.org/10.35445/alishlah.v18i2.9416)
- Miniukovich, De Angeli, Sulpizio, and Venuti, [Design Guidelines for Web Readability](https://doi.org/10.1145/3064663.3064711)

### Assistive technology and dyslexia applications

- Jing and Chen, [A Research Review: How Technology Helps to Improve the Learning Process of Learners with Dyslexia](https://doi.org/10.33736/jcshd.510.2017)
- Politi-Georgousi and Drigas, [Mobile Applications, An Emerging Powerful Tool for Dyslexia Screening and Intervention: A Systematic Literature Review](https://doi.org/10.3991/ijim.v14i18.15315)
- Madeira, Silva, Marcelino, and Ferreira, [Assistive Mobile Applications for Dyslexia](https://doi.org/10.1016/j.procs.2015.08.535)
- Gupta, Aflatoony, and Leonard, [Augmenta11y: Design for Dyslexia](https://doi.org/10.1145/3441852.3476530)
- Rello and Baeza-Yates, [Evaluation of DysWebxia: A Reading App Designed for People with Dyslexia](https://doi.org/10.1145/2596695.2596697)
- Rello, Kanvinde, and Baeza-Yates, [A Mobile Application for Displaying More Accessible eBooks for People with Dyslexia](https://doi.org/10.1016/j.procs.2012.10.026)
- Austin and Holloway, [Assistive Technology (AT), for What?](https://doi.org/10.3390/soc12060169)
- Svensson, Nordström, Lindeblad, Gustafson, Björn, Sand, Almgren/Bäck, and Nilsson, [Effects of Assistive Technology for Students with Reading and Writing Disabilities](https://www.tandfonline.com/doi/full/10.1080/17483107.2019.1646821)
- Lerga, Čandrlić, and Jakupović, [A Review on Assistive Technologies for Students with Dyslexia](https://doi.org/10.5220/0010434500640072)
- Paudel, Karki, Kafle, Poudel, and Neupane, [A comprehensive review of assistive technologies for children with dyslexia](https://arxiv.org/abs/2412.13241)

### Document processing and implementation context

- Hamad and Kaya, [A Detailed Analysis of Optical Character Recognition Technology](https://doi.org/10.18100/ijamec.270374)
- Zhou, Feng, Jiang, and Liao, [DeclarUI: Supporting Basic Mobile UI Tasks with Declarative UI and Large Language Models](https://arxiv.org/abs/2409.11667)

## Quick Start

Use DyslexicoKit as a Swift Package dependency in any iOS app that needs reader-configurable typography, reusable accessible text controls, PDF generation, or read-aloud support. The SDK targets iOS 16 and can be adopted gradually: start with the environment-based typography settings, then move individual screens to the custom views or modifiers when needed.

### Integration

1. In Xcode, open your app project and choose **File > Add Package Dependencies**.
2. Add the package URL:

```text
https://github.com/mipar52/dyslexico-ios-sdk.git
```

3. Select the `DyslexicoKit` library product and add it to your app target.
4. Import the SDK where you want to use it:

```swift
import DyslexicoKit
```

Set the typography settings once near the root of your SwiftUI hierarchy:

```swift
@main
struct ReadingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .dyslexicoTypography(.defaultSettings)
        }
    }
}
```

Then use DyslexicoKit views or modifiers inside the app:

```swift
DyslexicoText("Readable text", textSettings: .body)

Text("Native SwiftUI text")
    .dyslexicoText(role: .body)
```

### Sample App Testing

The repository includes a sample app that demonstrates the SDK by feature area: typography, views, PDF generation, and voice playback.

1. Open the sample project:

```text
sample-app/sample-app.xcodeproj
```

2. Select the `sample-app` scheme.
3. Choose an iOS simulator or a connected iOS device.
4. Build and run the app from Xcode.

The sample app uses the local package checkout, so changes made in `Sources/DyslexicoKit` can be tested immediately from the sample screens.

## Typography

The typography layer is the foundation of DyslexicoKit. It centralizes the reader's font family, base size, text role sizing, weights, colors, spacing, and letter highlighting so client apps can keep every screen consistent while still allowing each user to customize their reading experience.

### Typography Settings

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

### Custom Colors and Highlights

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

## Custom Views

The views layer is optional but useful when client apps want accessible, dyslexia-friendly UI components without rebuilding the same styling and interaction states. Use the prebuilt SwiftUI controls for common text, input, button, and label flows, or apply the view modifiers to native SwiftUI views when an existing design system needs to stay in place.

### SwiftUI Integration

Set typography once near the root of your SwiftUI view hierarchy:

```swift
ContentView()
    .dyslexicoTypography(userTypographySettings)
```

All DyslexicoKit views and text modifiers below that point will read the same settings from the SwiftUI environment.

### Text Views

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

### Text Fields

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

### Text Editors

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

### Buttons and Labels

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

### View Modifiers

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

### Attributed Strings

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
