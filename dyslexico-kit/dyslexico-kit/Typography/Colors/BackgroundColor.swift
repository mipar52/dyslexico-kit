//
//  BackgroundColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import Foundation
import SwiftUI
import UIKit

/// Background colors chosen to reduce visual strain behind readable text.
public enum BackgroundColor {
    /// A soft cream reading background.
    case cream

    /// A warm sepia reading background.
    case sepia

    /// A gentle pastel reading background.
    case pastel

    /// A dark reading background for low-light contexts.
    case dark

    /// A client-defined background color expressed with SwiftUI color components.
    case custom(red: Double, green: Double, blue: Double, opacity: Double = 1)
    
    /// The SwiftUI `Color` representation of the background color.
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
    
    /// The UIKit `UIColor` representation of the background color.
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
