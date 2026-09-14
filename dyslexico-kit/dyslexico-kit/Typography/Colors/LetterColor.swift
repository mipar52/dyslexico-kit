//
//  LetterColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI

public enum LetterColor {
    case black, brown, navy, charcoal, error

    public var color: Color {
        switch self {
        case .black:
            return DyslexicoColors.blackTextColor
        case .brown:
            return DyslexicoColors.brownTextColor
        case .navy:
            return DyslexicoColors.navyTextColor
        case .charcoal:
            return DyslexicoColors.charcoalTextColor
        case .error:
            return DyslexicoColors.semanticError
        }
    }
    
    public var uiColor: UIColor {
        switch self {
        case .black:
            return UIColor(DyslexicoColors.blackTextColor)
        case .brown:
            return UIColor(DyslexicoColors.brownTextColor)
        case .navy:
            return UIColor(DyslexicoColors.navyTextColor)
        case .charcoal:
            return UIColor(DyslexicoColors.charcoalTextColor)
        case .error:
            return UIColor(DyslexicoColors.semanticError)
        }
    }
    
    public func customColor(for color: Color) -> Color {
        return color
    }
    
    public func customUiColor(for color: UIColor) -> UIColor {
        return color
    }
}
