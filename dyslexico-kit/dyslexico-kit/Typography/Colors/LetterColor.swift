//
//  LetterColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI

enum LetterColor {
    case black, brown, navy, charcoal

    var color: Color {
        switch self {
        case .black:
            return DyslexicoColors.blackTextColor
        case .brown:
            return DyslexicoColors.brownTextColor
        case .navy:
            return DyslexicoColors.navyTextColor
        case .charcoal:
            return DyslexicoColors.charcoalTextColor
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .black:
            return UIColor(DyslexicoColors.blackTextColor)
        case .brown:
            return UIColor(DyslexicoColors.brownTextColor)
        case .navy:
            return UIColor(DyslexicoColors.navyTextColor)
        case .charcoal:
            return UIColor(DyslexicoColors.charcoalTextColor)
        }
    }
    
    func customColor(for color: Color) -> Color {
        return color
    }
    
    func customUiColor(for color: UIColor) -> UIColor {
        return color
    }
}
