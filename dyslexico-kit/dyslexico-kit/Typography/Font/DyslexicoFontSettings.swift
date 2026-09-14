//
//  DyslexicoFontSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoFontSettings {
    public static let defaultFont: DyslexicoFontSettings = .init(family: .lexend, size: 24)

    public let family: DyslexicoFontFamily
    public let weight: DyslexicoFontWeight?
    public let size: CGFloat
    public let isItalic: Bool

    public init(
        family: DyslexicoFontFamily,
        weight: DyslexicoFontWeight? = nil,
        size: CGFloat,
        isItalic: Bool = false
    ) {
        self.family = family
        self.weight = weight
        self.size = size
        self.isItalic = isItalic
    }
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
