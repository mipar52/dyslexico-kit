//
//  DyslexicoLetterHighlightOptions.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI

/// Letter-pair highlighting rules used by DyslexicoKit attributed text and PDF export.
public enum DyslexicoLetterHighlightOption: Hashable {
    /// Highlights the common "b" and "d" confusion pair with default colors.
    case bdPair

    /// Highlights the common "p" and "q" confusion pair with default colors.
    case pqPair

    /// Highlights the common "m" and "w" confusion pair with default colors.
    case mwPair

    /// Highlights a client-defined letter pair using the default custom pair colors.
    case customPair(Character, Character)

    /// Highlights a client-defined letter pair using client-defined colors for each letter.
    case customColoredPair(
        Character,
        Character,
        firstColor: DyslexicoHighlightColor,
        secondColor: DyslexicoHighlightColor
    )
    
    /// The two highlight colors used for this pair.
    public var pairColor: (DyslexicoHighlightColor, DyslexicoHighlightColor) {
        switch self {
        case .bdPair:
            return (.highlightB, .highlightD)
        case .pqPair:
            return (.highlightP, .highlightQ)
        case .mwPair:
            return (.highlightM, .highlightW)
        case .customPair:
            return (.highlightB, .highlightD)
        case .customColoredPair(_, _, let firstColor, let secondColor):
            return (firstColor, secondColor)
        }
    }
    
    /// Creates a custom letter-pair option using the default custom pair colors.
    public func makePair(for letter: Character, and letterTwo: Character) ->  DyslexicoLetterHighlightOption {
        return .customPair(letter, letterTwo)
    }

    /// Creates a custom letter-pair option with explicit colors for each letter.
    public static func makePair(
        for letter: Character,
        and letterTwo: Character,
        firstColor: DyslexicoHighlightColor,
        secondColor: DyslexicoHighlightColor
    ) -> DyslexicoLetterHighlightOption {
        .customColoredPair(
            letter,
            letterTwo,
            firstColor: firstColor,
            secondColor: secondColor
        )
    }
}
