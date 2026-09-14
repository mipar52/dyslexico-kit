//
//  DyslexicoFontSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoFontSettings {
    static let defaultFont: DyslexicoFontSettings = .init(family: .lexend, weight: .medium, size: 24)
    public let family: DyslexicoFontFamily
    public let weight: DyslexicoFontWeight?
    public let size: CGFloat
}

extension DyslexicoFontSettings {
    public var font: Font {
        DyslexicoFontResolver.font(from: self)
    }
}

extension DyslexicoFontSettings {
    public var uiFont: UIFont {
        DyslexicoFontResolver.uiFont(from: self)
    }
}
