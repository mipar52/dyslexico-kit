//
//  BackgroundColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI

enum BackgroundColor {
    case cream, sepia, pastel, dark
    
    var color: Color {
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
    
    var uiColor: UIColor {
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
}
