//
//  SampleText.swift
//  sample-app
//
//  Created by Milan Parađina on 22.09.2026..
//

import Foundation
import DyslexicoKit

enum SampleText {
    static let preview = "Readable text should feel calm, clear, and personal."

    static let note = "Readable text should adapt to each reader. DyslexicoKit keeps typography, spacing, voice, and PDF export connected to the same settings."

    static let longForm = """
    DyslexicoKit helps apps present text with reader-specific typography. A client app can let users choose the font, spacing, background color, and confusing-letter highlights that work best for them.

    The same settings can be reused in SwiftUI views, custom modifiers, generated PDFs, and voice playback flows.
    """
}

enum DemoFontFamily: String, CaseIterable, Identifiable {
    case atkinsonHyperlegible
    case lexend
    case openDyslexic

    var id: String { rawValue }

    var title: String {
        switch self {
        case .atkinsonHyperlegible:
            return "Atkinson"
        case .lexend:
            return "Lexend"
        case .openDyslexic:
            return "OpenDyslexic"
        }
    }

    var fontFamily: DyslexicoFontFamily {
        switch self {
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible
        case .lexend:
            return .lexend
        case .openDyslexic:
            return .openDyslexic
        }
    }
}

enum DemoLetterColor: String, CaseIterable, Identifiable {
    case black, brown, navy, charcoal, error

    var id: String { rawValue }

    var title: String {
        return self.rawValue.uppercased()
    }

    var color: LetterColor {
        switch self {
        case .black:
                .black
        case .brown:
                .brown
        case .navy:
                .navy
        case .charcoal:
                .charcoal
        case .error:
                .error
        }
    }
}

enum DemoBackgroundColor: String, CaseIterable, Identifiable {
    case cream, sepia, pastel, dark

    var id: String { rawValue }

    var title: String {
        return self.rawValue.uppercased()
    }

    var color: BackgroundColor {
        switch self {
        case .cream:
                .cream
        case .sepia:
                .sepia
        case .pastel:
                .pastel
        case .dark:
                .dark
        }
    }
}


extension DyslexicoSpeechPlaybackState {
    var sampleTitle: String {
        switch self {
        case .idle:
            return "Idle"
        case .playing:
            return "Playing"
        case .paused:
            return "Paused"
        }
    }
}
