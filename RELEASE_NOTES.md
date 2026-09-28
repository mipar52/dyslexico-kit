# DyslexicoKit 0.1.0

Initial public release of DyslexicoKit, a Swift Package for building dyslexia-friendly reading experiences on iOS.

## Highlights

- Typography settings for dyslexia-friendly reading preferences
- Bundled readable font support with automatic font registration
- SwiftUI views and modifiers for integrating DyslexicoKit into client apps
- Letter-pair highlighting for commonly confused letters
- Attributed string helpers for SwiftUI, UIKit, PDF, and custom rendering
- PDF generation using client-provided typography settings
- Text-to-speech support with Apple voices and read-aloud state tracking
- Sample app demonstrating typography, custom views, PDF export, and voice playback

## Features

### Typography

- Added `DyslexicoTypographySettings` as the main configuration model.
- Added support for font family, size, weight, italic style, colors, spacing, and letter highlights.
- Added semantic text roles through `DyslexicoTextRole`.
- Added per-text overrides through `DyslexicoTextSettings`.
- Added automatic bundled font registration for SDK-provided fonts.
- Added SwiftUI and UIKit font/color resolution helpers.

### SwiftUI Views

- Added `DyslexicoText`.
- Added `DyslexicoTextField`, including secure password input.
- Added `DyslexicoTextEditor`.
- Added `DyslexicoButton`.
- Added `DyslexicoLabel`.
- Added view modifiers for applying DyslexicoKit typography to native SwiftUI views.

### Attributed Strings

- Added `DyslexicoTextUtilities` for creating styled `AttributedString` and `NSAttributedString` values.
- Added letter-pair highlighting support in attributed text.
- `DyslexicoText` now renders through the attributed text pipeline so highlights are visible in SwiftUI.

### PDF Generation

- Added `DyslexicoPdfGenerator`.
- Added PDF document and configuration models.
- Added support for dyslexia-friendly and standard PDF export styles.
- PDF generation accepts custom typography settings, so clients can generate PDFs based on each reader's preferences.

### Voice and Read Aloud

- Added `DyslexicoSpeechController`.
- Added speech settings, playback state, speech segments, and speech errors.
- Added support for pause, resume, stop, queued segments, available voices, premium voice preference, and speech range callbacks.
- Added support for read-along UI by exposing the currently spoken range.

### Sample App

- Added a multi-screen sample app.
- Added global typography settings from a gear button.
- Added a scoped Typography screen preview.
- Added Views, PDF, and Voice demo screens.
- Added PDF-specific typography settings.
- Added voice read-along highlighting.

## Requirements

- iOS 16+
- Swift 5.9+
- Swift Package Manager

## Installation

Add the package in Xcode:

```text
https://github.com/mipar52/dyslexico-ios-sdk.git
```

Then import:

```swift
import DyslexicoKit
```

## Licensing

DyslexicoKit source code is licensed under the MIT License.

Bundled fonts remain under their original font licenses. See `THIRD_PARTY_NOTICES.md` for details.
