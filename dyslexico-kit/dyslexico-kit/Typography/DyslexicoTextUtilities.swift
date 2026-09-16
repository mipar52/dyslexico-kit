//
//  DyslexicoTextUtilities.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 15.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoTextUtilities {
    /// SwiftUI variant — for use inside SwiftUI views.
    /// Returns an AttributedString that can be passed to `Text(_:)`.
    static func createStyledAttributedString(
        _ text: String,
        with typography: DyslexicoTypographySettings,
        role: DyslexicoTextRole = .body
    ) -> AttributedString {
        var attributed = AttributedString(text)
        attributed.font = typography.font(for: role)
//        attributed.font = preferences.selectedFont.font(
//            size: preferences.fontSize,
//            type: type
//        )
        attributed.foregroundColor = typography.colorSettings.fontColor.color

        if typography.spacingSettings.letterSpacing > 0 {
            attributed.kern = typography.spacingSettings.letterSpacing // 1.5
        }

        DyslexicoHighlightUtilities.applyHighlights(to: &attributed, options: typography.fontHighlightOptions)
        return attributed
    }
    
    /// UIKit / Core Text variant — for PDF rendering and other UIKit consumers.
    /// Returns an NSAttributedString with all attributes needed for CTFramesetter.
    ///
    /// `bodyFont`, `textColor`, and `lineSpacing` are passed explicitly because
    /// PDF rendering needs to express them as concrete UIKit types,
    /// and the caller may want overrides (e.g. plain style vs dyslexia-friendly).
    /// public struct DyslexicoPdfUtilties {
    static func createStyledNSAttributedString(
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
