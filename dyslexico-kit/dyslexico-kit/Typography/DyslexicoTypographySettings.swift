//
//  DyslexicoTypographySettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 05.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoTypographySettings {
    
    public static let defaultSettings: DyslexicoTypographySettings = .init(
        fontSettings: .defaultFont,
        fontHighlightOptions: [.bdPair, .pqPair],
        colorSettings: .defaultSettings,
        spacingSettings: .defaultSpacing,
        isItalic: false)
    
    public let fontSettings: DyslexicoFontSettings
    public let fontHighlightOptions: Set<DyslexicoLetterHighlightOption>
    public let colorSettings: DyslexicoColorSettings
    public let spacingSettings: DyslexicoSpacingSettings
    public let isItalic: Bool

    public init(
        fontSettings: DyslexicoFontSettings,
        fontHighlightOptions: Set<DyslexicoLetterHighlightOption>,
        colorSettings: DyslexicoColorSettings,
        spacingSettings: DyslexicoSpacingSettings,
        isItalic: Bool = false
    ) {
        self.fontSettings = fontSettings
        self.fontHighlightOptions = fontHighlightOptions
        self.colorSettings = colorSettings
        self.spacingSettings = spacingSettings
        self.isItalic = isItalic
    }
}

extension DyslexicoTypographySettings {
    public func fontSettings(for role: DyslexicoTextRole) -> DyslexicoFontSettings {
        fontSettings(for: .init(role: role))
    }
    
    public func font(for role: DyslexicoTextRole) -> Font {
        DyslexicoFontResolver.font(from: fontSettings(for: role))
    }
    
    public func uiFont(for role: DyslexicoTextRole) -> UIFont {
        DyslexicoFontResolver.uiFont(from: fontSettings(for: role))
    }
    
    public func fontSettings(for textSettings: DyslexicoTextSettings) -> DyslexicoFontSettings {
        DyslexicoFontSettings(
            family: fontSettings.family,
            weight: textSettings.weightOverride ?? fontSettings.weight ?? textSettings.role.defaultWeight,
            size: max(10, fontSettings.size + textSettings.role.sizeOffset),
            isItalic: isItalic || textSettings.isItalic
        )
    }

    public func font(for textSettings: DyslexicoTextSettings) -> Font {
        DyslexicoFontResolver.font(from: fontSettings(for: textSettings))
    }

    public func uiFont(for textSettings: DyslexicoTextSettings) -> UIFont {
        DyslexicoFontResolver.uiFont(from: fontSettings(for: textSettings))
    }

    public func color(for textSettings: DyslexicoTextSettings) -> Color {
        (textSettings.colorOverride ?? colorSettings.fontColor).color
    }

    public func uiColor(for textSettings: DyslexicoTextSettings) -> UIColor {
        (textSettings.colorOverride ?? colorSettings.fontColor).uiColor
    }
}
