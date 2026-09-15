//
//  DyslexicoPdfUtilties.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoPdfUtilties {
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
