//
//  DyslexicoFontWeight.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import SwiftUI

/// Font weights DyslexicoKit can resolve for bundled, system, and custom fonts.
public enum DyslexicoFontWeight: String, CaseIterable {
    /// Black font weight.
    case black = "Black"

    /// Bold font weight.
    case bold = "Bold"

    /// Bold italic font variant.
    case boldItalic = "BoldItalic"

    /// Extra bold font weight.
    case extraBold = "ExtraBold"

    /// Italic font variant.
    case italic = "Italic"

    /// Light font weight.
    case light = "Light"

    /// Medium font weight.
    case medium = "Medium"

    /// Regular font weight.
    case regular = "Regular"

    /// Semi-bold font weight.
    case semiBold = "SemiBold"

    /// Thin font weight.
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
