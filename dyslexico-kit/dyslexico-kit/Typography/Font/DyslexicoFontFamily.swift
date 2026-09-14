//
//  DyslexicoFontFamily.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import SwiftUI

public enum DyslexicoFontFamily {
    case openDyslexic
    case atkinsonHyperlegible
    case lexend
    case systemDefault
    case custom(name: String, type: String)
    
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
