//
//  DyslexicoFontSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import Foundation
import SwiftUI

public struct DyslexicoFontSettings {
    static let defaultFont: DyslexicoFontSettings = .init(font: .lexend, type: .medium, size: 24)
    let font: DyslexicoFontOptions
    let type: DyslexicoFontTypeOption
    let size: CGFloat
}
