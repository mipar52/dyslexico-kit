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
        for options: Set<DyslexicoLetterHighlightOption>
    ) -> [(characters: [Character], swiftUIColor: Color, uiColor: UIColor)] {
        var entries: [(characters: [Character], swiftUIColor: Color, uiColor: UIColor)] = []
        
        options.forEach { option in
            switch option {
            case .bdPair:
                entries.append(contentsOf: makeEntries(
                    first: "b",
                    second: "d",
                    colors: option.pairColor
                ))
            case .pqPair:
                entries.append(contentsOf: makeEntries(
                    first: "p",
                    second: "q",
                    colors: option.pairColor
                ))
            case .mwPair:
                entries.append(contentsOf: makeEntries(
                    first: "m",
                    second: "w",
                    colors: option.pairColor
                ))
            case .customPair(let first, let second):
                entries.append(contentsOf: makeEntries(
                    first: first,
                    second: second,
                    colors: option.pairColor
                ))
            case .customColoredPair(let first, let second, _, _):
                entries.append(contentsOf: makeEntries(
                    first: first,
                    second: second,
                    colors: option.pairColor
                ))
            }
        }

        return entries
    }
    
    private static func makeEntries(
        first: Character,
        second: Character,
        colors: (DyslexicoHighlightColor, DyslexicoHighlightColor)
    ) -> [(characters: [Character], swiftUIColor: Color, uiColor: UIColor)] {
        [
            (
                characters: characterVariants(for: first),
                swiftUIColor: colors.0.color,
                uiColor: colors.0.uiColor
            ),
            (
                characters: characterVariants(for: second),
                swiftUIColor: colors.1.color,
                uiColor: colors.1.uiColor
            )
        ]
    }

    private static func characterVariants(for character: Character) -> [Character] {
        let variants = [
            String(character),
            String(character).lowercased(),
            String(character).uppercased()
        ]

        return Array(Set(variants.compactMap { value in
            guard value.count == 1 else { return nil }
            return value.first
        }))
    }
}
