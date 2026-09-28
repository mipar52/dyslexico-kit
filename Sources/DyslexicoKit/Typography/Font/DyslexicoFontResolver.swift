//
//  DyslexicoFontResolver.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import SwiftUI

/// Converts DyslexicoKit font settings into SwiftUI and UIKit font instances.
public enum DyslexicoFontResolver {
    /// Resolves a `DyslexicoFontSettings` value into a SwiftUI `Font`.
    public static func font(from settings: DyslexicoFontSettings) -> Font {
        DyslexicoFontRegistrar.registerBundledFontsIfNeeded()

        let weight = resolvedWeight(from: settings)

        switch settings.family {
        case .openDyslexic:
            return .openDyslexic(weight: supportedWeight(weight, for: settings.family), size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(weight: supportedWeight(weight, for: settings.family), size: settings.size)
        case .lexend:
            return .lexend(weight: supportedWeight(weight, for: settings.family), size: settings.size)
        case .systemDefault:
            return .system(size: settings.size, weight: weight.swiftUIWeight)
        case .custom(let name, let customWeight):
            return .dyslexicoCustom(name: name, weight: customWeight, size: settings.size)
        }
    }
    
    /// Resolves a `DyslexicoFontSettings` value into a UIKit `UIFont`.
    public static func uiFont(from settings: DyslexicoFontSettings) -> UIFont {
        DyslexicoFontRegistrar.registerBundledFontsIfNeeded()

        let weight = resolvedWeight(from: settings)

        switch settings.family {
        case .openDyslexic:
            return .openDyslexic(weight: supportedWeight(weight, for: settings.family), size: settings.size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(weight: supportedWeight(weight, for: settings.family), size: settings.size)
        case .lexend:
            return .lexend(weight: supportedWeight(weight, for: settings.family), size: settings.size)
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

    private static func supportedWeight(
        _ weight: DyslexicoFontWeight,
        for family: DyslexicoFontFamily
    ) -> DyslexicoFontWeight {
        switch family {
        case .openDyslexic, .atkinsonHyperlegible:
            switch weight {
            case .boldItalic:
                return .boldItalic
            case .italic:
                return .italic
            case .black, .bold, .extraBold, .medium, .semiBold:
                return .bold
            case .light, .regular, .thin:
                return .regular
            }

        case .lexend:
            switch weight {
            case .italic:
                return .regular
            case .boldItalic:
                return .bold
            default:
                return weight
            }

        case .systemDefault, .custom:
            return weight
        }
    }
}
