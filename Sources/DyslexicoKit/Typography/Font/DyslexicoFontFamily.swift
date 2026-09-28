//
//  DyslexicoFontFamily.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import SwiftUI

/// Font families supported by DyslexicoKit typography settings.
public enum DyslexicoFontFamily {
    
    /// Uses the bundled OpenDyslexic font family.
    case openDyslexic

    /// Uses the bundled Atkinson Hyperlegible font family.
    case atkinsonHyperlegible

    /// Uses the bundled Lexend font family.
    case lexend

    /// Uses the platform system font while preserving DyslexicoKit sizing and spacing.
    case systemDefault

    /// Uses a custom font registered by the client app.
    ///
    /// Pass the base font name and the weight suffix exactly as the font is registered with iOS.
    case custom(name: String, weight: String)
    
    var fontName: String {
        switch self {
        case .openDyslexic:
            return "OpenDyslexic"
        case .atkinsonHyperlegible:
            return "AtkinsonHyperlegible"
        case .lexend:
            return "Lexend"
        default:
            return "System"
        }
    }
}
