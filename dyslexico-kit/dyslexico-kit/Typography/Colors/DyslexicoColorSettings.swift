//
//  DyslexicoColorSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

public struct DyslexicoColorSettings {
    public let fontColor: LetterColor
    public let backgroundColor: BackgroundColor
    
    public static let defaultSettings: DyslexicoColorSettings = .init(fontColor: .black, backgroundColor: .cream)

    public init(fontColor: LetterColor, backgroundColor: BackgroundColor) {
        self.fontColor = fontColor
        self.backgroundColor = backgroundColor
    }
}
