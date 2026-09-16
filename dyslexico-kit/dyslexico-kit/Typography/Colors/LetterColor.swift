//
//  LetterColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI
import UIKit

public enum LetterColor {
    case black, brown, navy, charcoal, error
    case custom(red: Double, green: Double, blue: Double, opacity: Double = 1)

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
        case .custom(let red, let green, let blue, let opacity):
            return Color(red: red, green: green, blue: blue, opacity: opacity)
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
        case .custom:
            return UIColor(color)
        }
    }
}
