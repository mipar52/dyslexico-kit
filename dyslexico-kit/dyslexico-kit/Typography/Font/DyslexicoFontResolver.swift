//
//  DyslexicoFontResolver.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import SwiftUI

public enum DyslexicoFontResolver {
    public static func font(from settings: DyslexicoFontSettings) -> Font {
        switch settings.font {
        case .openDyslexic:
            return .openDyslexic(type: settings.type, size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(type: settings.type, size: settings.size)
        case .lexend:
            return .lexend(type: settings.type, size: settings.size)
        case .systemDefault:
            return .system(size: settings.size)
        }
    }
    
    public static func font(from settings: DyslexicoFontSettings) -> UIFont {
        switch settings.font {
        case .openDyslexic:
            return .openDyslexic(type: settings.type, size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(type: settings.type, size: settings.size)
        case .lexend:
            return .lexend(type: settings.type, size: settings.size)
        case .systemDefault:
            return .systemFont(ofSize: settings.size)
        }
    }
}
