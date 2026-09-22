//
//  DyslexicoHighlightColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation
import SwiftUI
import UIKit

/// Highlight colors used to visually distinguish confusing letter pairs.
public enum DyslexicoHighlightColor: Hashable {
    /// Default highlight color for the letter "b".
    case highlightB

    /// Default highlight color for the letter "d".
    case highlightD

    /// Default highlight color for the letter "p".
    case highlightP

    /// Default highlight color for the letter "q".
    case highlightQ

    /// Default highlight color for the letter "m".
    case highlightM

    /// Default highlight color for the letter "w".
    case highlightW

    /// A client-defined highlight color expressed with SwiftUI color components.
    case custom(red: Double, green: Double, blue: Double, opacity: Double = 1)

    /// The SwiftUI `Color` representation of the highlight color.
    public var color: Color {
        switch self {
        case .highlightB:
            return DyslexicoColors.highlightB
        case .highlightD:
            return DyslexicoColors.highlightD
        case .highlightP:
            return DyslexicoColors.highlightP
        case .highlightQ:
            return DyslexicoColors.highlightQ
        case .highlightM:
            return DyslexicoColors.highlightM
        case .highlightW:
            return DyslexicoColors.highlightW
        case .custom(let red, let green, let blue, let opacity):
            return Color(red: red, green: green, blue: blue, opacity: opacity)
        }
    }

    /// The UIKit `UIColor` representation of the highlight color.
    public var uiColor: UIColor {
        UIColor(color)
    }
}
