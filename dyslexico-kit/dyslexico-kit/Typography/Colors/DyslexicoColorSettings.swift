//
//  DyslexicoColorSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

public struct DyslexicoColorSettings {
    public let fontColor: LetterColor
    public let backgroundColor: BackgroundColor
    
    static let defaultSettings: DyslexicoColorSettings = .init(fontColor: .black, backgroundColor: .cream)
}
