//
//  DyslexicoLetterHighlightOptions.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI

public enum DyslexicoLetterHighlightOption: Hashable {
    case bdPair
    case pqPair
    case mwPair
    case customPair(Character, Character)
    case customColoredPair(
        Character,
        Character,
        firstColor: DyslexicoHighlightColor,
        secondColor: DyslexicoHighlightColor
    )
    
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
    
    public func makePair(for letter: Character, and letterTwo: Character) ->  DyslexicoLetterHighlightOption {
        return .customPair(letter, letterTwo)
    }

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
