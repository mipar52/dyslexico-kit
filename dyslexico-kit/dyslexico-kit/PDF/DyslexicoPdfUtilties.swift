//
//  DyslexicoPdfUtilties.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoPdfUtilties {
    /// SwiftUI variant — for use inside SwiftUI views.
    /// Returns an AttributedString that can be passed to `Text(_:)`.
//    static func createStyledAttributedString(
//        _ text: String,
//        with typography: DyslexicoTypographySettings,
//        weight: DyslexicoFontWeight = .regular
//    ) -> AttributedString {
//        var attributed = AttributedString(text)
//        attributed.font = typography.font(for: <#T##DyslexicoTextRole#>)
//        attributed.font = preferences.selectedFont.font(
//            size: preferences.fontSize,
//            type: type
//        )
//        attributed.foregroundColor = preferences.selectedTextColor.color
//        
//        if preferences.increasedLetterSpacing {
//            attributed.kern = 1.5
//        }
//        
//        applyHighlights(to: &attributed, options: preferences.fontHighlightOptions)
//        return attributed
//    }
    
    /// UIKit / Core Text variant — for PDF rendering and other UIKit consumers.
    /// Returns an NSAttributedString with all attributes needed for CTFramesetter.
    ///
    /// `bodyFont`, `textColor`, and `lineSpacing` are passed explicitly because
    /// PDF rendering needs to express them as concrete UIKit types,
    /// and the caller may want overrides (e.g. plain style vs dyslexia-friendly).
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
    
    private static func highlightColors(
        for options:  Set<DyslexicoLetterHighlightOption>
    ) -> [(characters: [Character], swiftUIColor: Color, uiColor: UIColor)] {
        var entries: [(characters: [Character], swiftUIColor: Color, uiColor: UIColor)] = []
        
        options.forEach { pair in
            if pair == .bdPair {
                entries.append((
                    characters: ["b", "B"],
                    swiftUIColor: DyslexicoColors.highlightB,
                    uiColor: UIColor(DyslexicoColors.highlightB)
                ))
                entries.append((
                    characters: ["d", "D"],
                    swiftUIColor: DyslexicoColors.highlightD,
                    uiColor: UIColor(DyslexicoColors.highlightD)
                ))
            }
            if pair == .pqPair {
                entries.append((
                    characters: ["p", "P"],
                    swiftUIColor: DyslexicoColors.highlightP,
                    uiColor: UIColor(DyslexicoColors.highlightP)
                ))
                entries.append((
                    characters: ["q", "Q"],
                    swiftUIColor: DyslexicoColors.highlightQ,
                    uiColor: UIColor(DyslexicoColors.highlightQ)
                ))
            }
            if pair == .mwPair {
                entries.append((
                    characters: ["m", "M"],
                    swiftUIColor: DyslexicoColors.highlightM,
                    uiColor: UIColor(DyslexicoColors.highlightM)
                ))
                entries.append((
                    characters: ["w", "W"],
                    swiftUIColor: DyslexicoColors.highlightW,
                    uiColor: UIColor(DyslexicoColors.highlightW)
                ))
            }
            
            // need case for custom pairs
        }
        

        
        return entries
    }
    
    private static func applyHighlights(
        to attributed: inout AttributedString,
        options: Set<DyslexicoLetterHighlightOption>
    ) {
        let entries = highlightColors(for: options)
        for entry in entries {
            applyHighlight(to: &attributed, characters: entry.characters, color: entry.swiftUIColor)
        }
    }
    
    private static func applyHighlight(
        to attributed: inout AttributedString,
        characters: [Character],
        color: Color
    ) {
        let plainString = String(attributed.characters)
        for (index, char) in plainString.enumerated() {
            guard characters.contains(char) else { continue }
            let stringIndex = plainString.index(plainString.startIndex, offsetBy: index)
            guard let attrIndex = AttributedString.Index(stringIndex, within: attributed) else { continue }
            let nextAttrIndex = attributed.index(afterCharacter: attrIndex)
            attributed[attrIndex..<nextAttrIndex].backgroundColor = color
        }
    }
    
    private static func applyHighlightsNS(
        to attributed: NSMutableAttributedString,
        options:  Set<DyslexicoLetterHighlightOption>
    ) {
        let text = attributed.string
        let entries = highlightColors(for: options)
        
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
