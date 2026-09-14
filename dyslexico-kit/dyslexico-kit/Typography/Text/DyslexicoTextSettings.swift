//
//  DyslexicoTextSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

public struct DyslexicoTextSettings {
    public var role: DyslexicoTextRole
    public var weightOverride: DyslexicoFontWeight?
    public var colorOverride: LetterColor?
    public var isItalic: Bool

    public init(
        role: DyslexicoTextRole,
        weightOverride: DyslexicoFontWeight? = nil,
        colorOverride: LetterColor? = nil,
        isItalic: Bool = false
    ) {
        self.role = role
        self.weightOverride = weightOverride
        self.colorOverride = colorOverride
        self.isItalic = isItalic
    }
    
    public static let body = DyslexicoTextSettings(role: .body)
    public static let title = DyslexicoTextSettings(role: .title)
    public static let caption = DyslexicoTextSettings(role: .caption)
    public static let input = DyslexicoTextSettings(role: .input)
    public static let button = DyslexicoTextSettings(role: .button)
}
