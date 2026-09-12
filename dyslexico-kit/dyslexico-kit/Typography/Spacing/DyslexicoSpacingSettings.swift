//
//  DyslexicoSpacingSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import Foundation

struct DyslexicoSpacingSettings: Codable {
    let lineSpacing: CGFloat
    let letterSpacing: CGFloat
    
    static let defaultSpacing: DyslexicoSpacingSettings = .init(lineSpacing: 1.5, letterSpacing: 0.05)
}
