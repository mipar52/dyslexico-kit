//
//  DyslexicoFontResolver.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import SwiftUI

public enum DyslexicoFontResolver {
    public static func font(from settings: DyslexicoFontSettings) -> Font {
        switch settings.family {
        case .openDyslexic:
            return .openDyslexic(weight: settings.weight, size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(weight: settings.weight, size: settings.size)
        case .lexend:
            return .lexend(weight: settings.weight, size: settings.size)
        case .systemDefault:
            return .system(size: settings.size)
        case .custom(let name, let weight):
            return .dyslexicoCustom(name: name, weight: weight, size: settings.size)
        }
    }
    
    public static func uiFont(from settings: DyslexicoFontSettings) -> UIFont {
        switch settings.family {
        case .openDyslexic:
            return .openDyslexic(weight: settings.weight, size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(weight: settings.weight, size: settings.size)
        case .lexend:
            return .lexend(weight: settings.weight, size: settings.size)
        case .systemDefault:
            return .systemFont(ofSize: settings.size)
        case .custom(let name, let weight):
            return .dyslexicoCustom(name: name, weight: weight, size: settings.size)
        }
    }
}
