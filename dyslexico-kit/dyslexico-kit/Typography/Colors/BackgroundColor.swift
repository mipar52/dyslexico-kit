//
//  BackgroundColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI
import UIKit

public enum BackgroundColor {
    case cream, sepia, pastel, dark
    case custom(red: Double, green: Double, blue: Double, opacity: Double = 1)
    
    public var color: Color {
        switch self {
        case .cream:
            return DyslexicoColors.creamBackgroundColor
        case .sepia:
            return DyslexicoColors.sepiaBackgrounColor
        case .pastel:
            return DyslexicoColors.pastelBackgroundColor
        case .dark:
            return DyslexicoColors.darkBackgroundColor
        case .custom(let red, let green, let blue, let opacity):
            return Color(red: red, green: green, blue: blue, opacity: opacity)
        }
    }
    
    public var uiColor: UIColor {
        switch self {
        case .cream:
            return UIColor(DyslexicoColors.creamBackgroundColor)
        case .sepia:
            return UIColor(DyslexicoColors.sepiaBackgrounColor)
        case .pastel:
            return UIColor(DyslexicoColors.pastelBackgroundColor)
        case .dark:
            return UIColor(DyslexicoColors.darkBackgroundColor)
        case .custom:
            return UIColor(color)
        }
    }
}
