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
}

extension DyslexicoTypographySettings {
    public func fontSettings(for role: DyslexicoTextRole) -> DyslexicoFontSettings {
        DyslexicoFontSettings(
            family: fontSettings.family,
            weight: fontSettings.weight,
            size: max(10, fontSettings.size + role.sizeOffset)
        )
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
            weight: fontSettings.weight ?? textSettings.role.defaultWeight,
            size: max(10, fontSettings.size + textSettings.role.sizeOffset)
        )
    }
}
