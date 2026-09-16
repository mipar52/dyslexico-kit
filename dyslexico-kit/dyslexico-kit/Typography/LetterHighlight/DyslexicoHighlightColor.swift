//
//  DyslexicoHighlightColor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation
import SwiftUI
import UIKit

public enum DyslexicoHighlightColor: Hashable {
    case highlightB
    case highlightD
    case highlightP
    case highlightQ
    case highlightM
    case highlightW
    case custom(red: Double, green: Double, blue: Double, opacity: Double = 1)

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

    public var uiColor: UIColor {
        UIColor(color)
    }
}
