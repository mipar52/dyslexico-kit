//
//  DyslexicoTypographySettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 05.09.2026..
//

import Foundation
import SwiftUI

struct DyslexicoTypographySettings {
    
    static let defaultSettings: DyslexicoTypographySettings = .init(
        fontSettings: .defaultFont,
        fontHighlightOptions: [.bdPair, .pqPair],
        colorSettings: .defaultSettings,
        spacingSettings: .defaultSpacing,
        isItalic: false)
    
    let fontSettings: DyslexicoFontSettings
    let fontHighlightOptions: Set<DyslexicoLetterHighlightOption>
    let colorSettings: DyslexicoColorSettings
    let spacingSettings: DyslexicoSpacingSettings
    let isItalic: Bool
}

extension DyslexicoTypographySettings {
    public func fontSettings(for role: DyslexicoTextRole) -> DyslexicoFontSettings {
        DyslexicoFontSettings(
            font: fontSettings.font,
            type: fontSettings.type,
            size: max(10, fontSettings.size + role.sizeOffset)
        )
    }
    
    public func font(for role: DyslexicoTextRole) -> Font {
        DyslexicoFontResolver.font(from: fontSettings(for: role))
    }
    
    public func uiFont(for role: DyslexicoTextRole) -> UIFont {
        DyslexicoFontResolver.uiFont(from: fontSettings(for: role))
    }
}
