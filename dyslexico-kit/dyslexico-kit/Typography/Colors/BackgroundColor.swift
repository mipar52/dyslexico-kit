//
//  BackgroundColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI

public enum BackgroundColor {
    case cream, sepia, pastel, dark
    
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
        }
    }
    
    public func customColor(for color: Color) -> Color {
        return color
    }
    
    public func customUiColor(for color: UIColor) -> UIColor {
        return color
    }
}
