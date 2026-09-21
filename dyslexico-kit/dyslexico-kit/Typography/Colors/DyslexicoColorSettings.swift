//
//  DyslexicoColorSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

/// Foreground and background color choices used by DyslexicoKit text surfaces.
public struct DyslexicoColorSettings {
    /// The default text color used when a text element does not provide an override.
    public let fontColor: LetterColor

    /// The default readable background color used by DyslexicoKit backgrounds and PDFs.
    public let backgroundColor: BackgroundColor
    
    /// The recommended starter colors for dyslexia-friendly reading.
    public static let defaultSettings: DyslexicoColorSettings = .init(fontColor: .black, backgroundColor: .cream)

    /// Creates color settings for text and readable backgrounds.
    ///
    /// - Parameters:
    ///   - fontColor: The default foreground color.
    ///   - backgroundColor: The default readable background color.
    public init(fontColor: LetterColor, backgroundColor: BackgroundColor) {
        self.fontColor = fontColor
        self.backgroundColor = backgroundColor
    }
}
