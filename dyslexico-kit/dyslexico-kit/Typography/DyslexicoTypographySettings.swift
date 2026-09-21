//
//  DyslexicoTypographySettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 05.09.2026..
//

import Foundation
import SwiftUI

/// A complete typography configuration used by DyslexicoKit views, modifiers, attributed strings, and PDF export.
public struct DyslexicoTypographySettings {
    
    /// The recommended starter configuration for dyslexia-friendly text rendering.
    public static let defaultSettings: DyslexicoTypographySettings = .init(
        fontSettings: .defaultFont,
        fontHighlightOptions: [.bdPair, .pqPair],
        colorSettings: .defaultSettings,
        spacingSettings: .defaultSpacing,
        isItalic: false)
    
    /// The base font family, size, weight, and italic style used before role-specific adjustments are applied.
    public let fontSettings: DyslexicoFontSettings

    /// The letter pairs that should receive visual highlighting in supported text and PDF output.
    public let fontHighlightOptions: Set<DyslexicoLetterHighlightOption>

    /// The foreground and background colors used for readable DyslexicoKit content.
    public let colorSettings: DyslexicoColorSettings

    /// The line and letter spacing applied to text rendered through DyslexicoKit.
    public let spacingSettings: DyslexicoSpacingSettings

    /// A global italic flag applied in addition to any per-text italic setting.
    public let isItalic: Bool

    /// Creates a typography configuration that can be injected into SwiftUI with `.dyslexicoTypography(_:)`.
    ///
    /// - Parameters:
    ///   - fontSettings: The base font configuration used across all text roles.
    ///   - fontHighlightOptions: The letter highlight rules applied to supported text.
    ///   - colorSettings: The text and background colors used by DyslexicoKit.
    ///   - spacingSettings: The line and letter spacing values used by DyslexicoKit.
    ///   - isItalic: Whether text should prefer italic variants globally.
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
    /// Resolves concrete font settings for a semantic text role such as title, body, input, or button.
    public func fontSettings(for role: DyslexicoTextRole) -> DyslexicoFontSettings {
        fontSettings(for: .init(role: role))
    }
    
    /// Creates a SwiftUI `Font` for a semantic text role.
    public func font(for role: DyslexicoTextRole) -> Font {
        DyslexicoFontResolver.font(from: fontSettings(for: role))
    }
    
    /// Creates a UIKit `UIFont` for a semantic text role, useful for PDF generation and UIKit integrations.
    public func uiFont(for role: DyslexicoTextRole) -> UIFont {
        DyslexicoFontResolver.uiFont(from: fontSettings(for: role))
    }
    
    /// Resolves concrete font settings by combining global typography settings with per-text overrides.
    ///
    /// The text role supplies the default size offset and weight. `DyslexicoTextSettings` can override the
    /// weight, color, and italic style for one piece of text without changing the global typography.
    public func fontSettings(for textSettings: DyslexicoTextSettings) -> DyslexicoFontSettings {
        DyslexicoFontSettings(
            family: fontSettings.family,
            weight: textSettings.weightOverride ?? fontSettings.weight ?? textSettings.role.defaultWeight,
            size: max(10, fontSettings.size + textSettings.role.sizeOffset),
            isItalic: isItalic || textSettings.isItalic
        )
    }

    /// Creates a SwiftUI `Font` from global typography settings and per-text overrides.
    public func font(for textSettings: DyslexicoTextSettings) -> Font {
        DyslexicoFontResolver.font(from: fontSettings(for: textSettings))
    }

    /// Creates a UIKit `UIFont` from global typography settings and per-text overrides.
    public func uiFont(for textSettings: DyslexicoTextSettings) -> UIFont {
        DyslexicoFontResolver.uiFont(from: fontSettings(for: textSettings))
    }

    /// Resolves the SwiftUI text color for a piece of text, using a per-text override when provided.
    public func color(for textSettings: DyslexicoTextSettings) -> Color {
        (textSettings.colorOverride ?? colorSettings.fontColor).color
    }

    /// Resolves the UIKit text color for a piece of text, using a per-text override when provided.
    public func uiColor(for textSettings: DyslexicoTextSettings) -> UIColor {
        (textSettings.colorOverride ?? colorSettings.fontColor).uiColor
    }
}
