//
//  DyslexicoFontSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoFontSettings {
    static let defaultFont: DyslexicoFontSettings = .init(font: .lexend, type: .medium, size: 24)
    let font: DyslexicoFontOptions
    let type: DyslexicoFontTypeOption
    let size: CGFloat
    
    func getFont() -> Font {
        switch font {
        case .openDyslexic:
            return .openDyslexic(type: type, size: size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(type: type, size: size)
        case .lexend:
            return .lexend(type: type, size: size)
        case .systemDefault:
            return .system(size: size)
        }
        return .dyslexicoCustom(name: font.fontName, type: type.rawValue, size: size)
    }
    
    func getUiFont() -> UIFont {
        switch font {
        case .openDyslexic:
            return .openDyslexic(type: type, size: size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(type: type, size: size)
        case .lexend:
            return .lexend(type: type, size: size)
        case .systemDefault:
            return .systemFont(ofSize: size)
        }
        return .dyslexicoCustom(name: font.fontName, type: type.rawValue, size: size)
    }
}
