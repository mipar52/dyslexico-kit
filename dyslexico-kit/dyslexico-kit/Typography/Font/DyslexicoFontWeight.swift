//
//  DyslexicoFontWeight.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import SwiftUI

public enum DyslexicoFontWeight: String, CaseIterable {
    case black = "Black"
    case bold = "Bold"
    case boldItalic = "BoldItalic"
    case extraBold = "ExtraBold"
    case italic = "Italic"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
    case thin = "Thin"
}

extension DyslexicoFontWeight {
    var swiftUIWeight: Font.Weight {
        switch self {
        case .black:
            return .black
        case .bold, .boldItalic:
            return .bold
        case .extraBold:
            return .heavy
        case .light:
            return .light
        case .medium:
            return .medium
        case .semiBold:
            return .semibold
        case .thin:
            return .thin
        case .italic, .regular:
            return .regular
        }
    }

    var uiFontWeight: UIFont.Weight {
        switch self {
        case .black:
            return .black
        case .bold, .boldItalic:
            return .bold
        case .extraBold:
            return .heavy
        case .light:
            return .light
        case .medium:
            return .medium
        case .semiBold:
            return .semibold
        case .thin:
            return .thin
        case .italic, .regular:
            return .regular
        }
    }

    func italicized() -> DyslexicoFontWeight {
        switch self {
        case .bold:
            return .boldItalic
        case .regular:
            return .italic
        default:
            return self
        }
    }
}
