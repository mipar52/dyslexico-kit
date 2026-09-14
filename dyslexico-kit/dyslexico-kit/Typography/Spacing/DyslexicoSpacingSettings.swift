//
//  DyslexicoSpacingSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import Foundation

public struct DyslexicoSpacingSettings: Codable {
    public let lineSpacing: CGFloat
    public let letterSpacing: CGFloat
    
    static let defaultSpacing: DyslexicoSpacingSettings = .init(lineSpacing: 1.5, letterSpacing: 0.05)
}
