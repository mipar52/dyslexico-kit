//
//  DyslexicoTextUtilities.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 15.09.2026..
//

import Foundation
import SwiftUI

/// Helpers for creating styled attributed text from DyslexicoKit typography settings.
public struct DyslexicoTextUtilities {
    /// Creates a SwiftUI `AttributedString` using DyslexicoKit font, color, spacing, and highlight settings.
    ///
    /// Use this when a custom SwiftUI view needs an attributed text value instead of `DyslexicoText`.
    ///
    /// - Parameters:
    ///   - text: The plain text to style.
    ///   - typography: The typography configuration used to resolve the final attributes.
    ///   - role: The semantic role used for font sizing and weight.
    /// - Returns: An attributed string suitable for `Text(_:)` and other SwiftUI attributed text APIs.
    public static func createStyledAttributedString(
        _ text: String,
        with typography: DyslexicoTypographySettings,
        role: DyslexicoTextRole = .body
    ) -> AttributedString {
        createStyledAttributedString(
            text,
            with: typography,
            textSettings: DyslexicoTextSettings(role: role)
        )
    }

    /// Creates a SwiftUI `AttributedString` using DyslexicoKit font, color, spacing, and highlight settings.
    ///
    /// Use this overload when a custom SwiftUI view needs the same role-specific styling and overrides
    /// that `DyslexicoText` uses.
    ///
    /// - Parameters:
    ///   - text: The plain text to style.
    ///   - typography: The typography configuration used to resolve the final attributes.
    ///   - textSettings: The semantic role and optional per-text overrides used for styling.
    /// - Returns: An attributed string suitable for `Text(_:)` and other SwiftUI attributed text APIs.
    public static func createStyledAttributedString(
        _ text: String,
        with typography: DyslexicoTypographySettings,
        textSettings: DyslexicoTextSettings
    ) -> AttributedString {
        var attributed = AttributedString(text)
        attributed.font = typography.font(for: textSettings)
        attributed.foregroundColor = typography.color(for: textSettings)

        if typography.spacingSettings.letterSpacing > 0 {
            attributed.kern = typography.spacingSettings.letterSpacing
        }

        DyslexicoHighlightUtilities.applyHighlights(to: &attributed, options: typography.fontHighlightOptions)
        return attributed
    }
    
    /// Creates a UIKit `NSAttributedString` for PDF rendering, Core Text, and UIKit consumers.
    ///
    /// - Parameters:
    ///   - text: The plain text to style.
    ///   - bodyFont: The concrete font used for the body text.
    ///   - textColor: The text color used for the attributed string.
    ///   - kerning: The character spacing applied to the text.
    ///   - lineSpacing: The paragraph line spacing applied to the text.
    ///   - highlightOptions: The letter highlight rules to apply when highlights are enabled.
    ///   - includeHighlights: Whether highlight background attributes should be added.
    /// - Returns: An attributed string suitable for UIKit, Core Text, and PDF drawing.
    public static func createStyledNSAttributedString(
        _ text: String,
        bodyFont: UIFont,
        textColor: UIColor,
        kerning: CGFloat,
        lineSpacing: CGFloat,
        highlightOptions: Set<DyslexicoLetterHighlightOption>,
        includeHighlights: Bool
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let baseAttrs: [NSAttributedString.Key: Any] = [
            .font: bodyFont,
            .foregroundColor: textColor,
            .kern: kerning,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributed = NSMutableAttributedString(string: text, attributes: baseAttrs)
        
        if includeHighlights {
            applyHighlightsNS(to: attributed, options: highlightOptions)
        }
        
        return attributed
    }
    
    // MARK: - Shared highlight logic
    
    private static func applyHighlightsNS(
        to attributed: NSMutableAttributedString,
        options:  Set<DyslexicoLetterHighlightOption>
    ) {
        let text = attributed.string
        let entries = DyslexicoHighlightUtilities.highlightColors(for: options)
        
        for entry in entries {
            for character in entry.characters {
                var searchRange = text.startIndex..<text.endIndex
                while let range = text.range(of: String(character), range: searchRange) {
                    let nsRange = NSRange(range, in: text)
                    attributed.addAttribute(.dyslexicoHighlightBackground, value: entry.uiColor, range: nsRange)
                    searchRange = range.upperBound..<text.endIndex
                }
            }
        }
    }
}

extension NSAttributedString.Key {
    nonisolated static let dyslexicoHighlightBackground = NSAttributedString.Key("dyslexicoHighlightBackground")
}
