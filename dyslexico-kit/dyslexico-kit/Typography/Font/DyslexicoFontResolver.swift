//
//  DyslexicoFontResolver.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import SwiftUI

public enum DyslexicoFontResolver {
    public static func font(from settings: DyslexicoFontSettings) -> Font {
        let weight = resolvedWeight(from: settings)

        switch settings.family {
        case .openDyslexic:
            return .openDyslexic(weight: weight, size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(weight: weight, size: settings.size)
        case .lexend:
            return .lexend(weight: weight, size: settings.size)
        case .systemDefault:
            return .system(size: settings.size, weight: weight.swiftUIWeight)
        case .custom(let name, let customWeight):
            return .dyslexicoCustom(name: name, weight: customWeight, size: settings.size)
        }
    }
    
    public static func uiFont(from settings: DyslexicoFontSettings) -> UIFont {
        let weight = resolvedWeight(from: settings)

        switch settings.family {
        case .openDyslexic:
            return .openDyslexic(weight: weight, size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(weight: weight, size: settings.size)
        case .lexend:
            return .lexend(weight: weight, size: settings.size)
        case .systemDefault:
            return .systemFont(ofSize: settings.size, weight: weight.uiFontWeight)
        case .custom(let name, let customWeight):
            return .dyslexicoCustom(name: name, weight: customWeight, size: settings.size)
        }
    }

    private static func resolvedWeight(from settings: DyslexicoFontSettings) -> DyslexicoFontWeight {
        let weight = settings.weight ?? .regular
        return settings.isItalic ? weight.italicized() : weight
    }
}
