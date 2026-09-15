//
//  DyslexicoHighlightUtilities.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 15.09.2026..
//

import Foundation
import SwiftUI

struct DyslexicoHighlightUtilities {
    static func applyHighlights(
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
    
    static func highlightColors(
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
    
}
