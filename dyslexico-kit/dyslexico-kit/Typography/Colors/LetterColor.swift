//
//  LetterColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI
import UIKit

/// Text colors chosen for readable dyslexia-friendly content.
public enum LetterColor {
    /// A high-contrast black text color.
    case black

    /// A warm brown text color.
    case brown

    /// A deep navy text color.
    case navy

    /// A softer charcoal text color.
    case charcoal

    /// The semantic error color used for validation and destructive text.
    case error

    /// A client-defined text color expressed with SwiftUI color components.
    case custom(red: Double, green: Double, blue: Double, opacity: Double = 1)

    /// The SwiftUI `Color` representation of the text color.
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
    
    /// The UIKit `UIColor` representation of the text color.
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
