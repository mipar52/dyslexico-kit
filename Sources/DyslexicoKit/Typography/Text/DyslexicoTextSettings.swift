//
//  DyslexicoTextSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

/// Per-text overrides that describe how one piece of text should be rendered within a typography configuration.
public struct DyslexicoTextSettings {
    /// The semantic role that controls default size and weight behavior.
    public var role: DyslexicoTextRole

    /// An optional font weight override for this text only.
    public var weightOverride: DyslexicoFontWeight?

    /// An optional text color override for this text only.
    public var colorOverride: LetterColor?

    /// Whether this text should prefer an italic font variant.
    public var isItalic: Bool

    /// Creates settings for one text element.
    ///
    /// - Parameters:
    ///   - role: The semantic text role used for default sizing and weight.
    ///   - weightOverride: An optional weight that replaces the role or global default.
    ///   - colorOverride: An optional color that replaces the global font color.
    ///   - isItalic: Whether this text should prefer italic variants.
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
    
    /// Preset settings for standard paragraph text.
    public static let body = DyslexicoTextSettings(role: .body)

    /// Preset settings for prominent headings and document titles.
    public static let title = DyslexicoTextSettings(role: .title)

    /// Preset settings for labels, helper text, and secondary copy.
    public static let caption = DyslexicoTextSettings(role: .caption)

    /// Preset settings for editable input text.
    public static let input = DyslexicoTextSettings(role: .input)

    /// Preset settings for button labels and actions.
    public static let button = DyslexicoTextSettings(role: .button)
}
