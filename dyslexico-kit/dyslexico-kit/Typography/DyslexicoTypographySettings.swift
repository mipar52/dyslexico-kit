//
//  DyslexicoTypographySettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 05.09.2026..
//

import Foundation

struct DyslexicoTypographySettings {
    
    static let defaultSettings: DyslexicoTypographySettings = .init(
        fontSettings: .defaultFont,
        fontHighlightOptions: [.bdPair, .pqPair],
        colorSettings: .defaultSettings,
        spacingSettings: .defaultSpacing)
    
    let fontSettings: DyslexicoFontSettings
    let fontHighlightOptions: Set<DyslexicoLetterHighlightOption>
    let colorSettings: DyslexicoColorSettings
    let spacingSettings: DyslexicoSpacingSettings
}
