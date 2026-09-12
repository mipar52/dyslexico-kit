//
//  DyslexicoLetterHighlightOptions.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI

enum DyslexicoLetterHighlightOption: Hashable {
    case bdPair
    case pqPair
    case mwPair
    case customPair(Character, Character)
    
    var pairColor: (Color, Color) {
        switch self {
        case .bdPair:
            return (DyslexicoColors.highlightB, DyslexicoColors.highlightD)
        case .pqPair:
            return (DyslexicoColors.highlightP, DyslexicoColors.highlightQ)
        case .mwPair:
            return (DyslexicoColors.highlightM, DyslexicoColors.highlightW)
        default:
            return (.clear, .clear)
        }
    }
    
    func makePair(for letter: Character, and letterTwo: Character) ->  DyslexicoLetterHighlightOption {
        return .customPair(letter, letterTwo)
    }
}
