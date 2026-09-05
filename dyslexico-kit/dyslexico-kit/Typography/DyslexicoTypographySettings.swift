//
//  DyslexicoTypographySettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 05.09.2026..
//

import Foundation

struct DyslexicoTypographySettings {
    
    let selectedFont: FontOptions
    let fontSize: CGFloat
    let increasedLetterSpacing: CGFloat
    let fontHighlightOptions: FontHighlightOptions
    
    init(selectedFont: FontOptions = .lexend, fontSize: CGFloat = 24, increasedLetterSpacing: CGFloat = 5, fontHighlightOptions: FontHighlightOptions) {
        self.selectedFont = selectedFont
        self.fontSize = fontSize
        self.increasedLetterSpacing = increasedLetterSpacing
        self.fontHighlightOptions = fontHighlightOptions
    }
}


enum FontOptions {
    case lexend, atkison, openDyslexic, custom(String)
}


struct FontHighlightOptions {
    let mwPair: Bool
}
