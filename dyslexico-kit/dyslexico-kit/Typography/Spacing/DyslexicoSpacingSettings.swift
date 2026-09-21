//
//  DyslexicoSpacingSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import Foundation

/// Line and letter spacing values used by DyslexicoKit text and PDF rendering.
public struct DyslexicoSpacingSettings: Codable {
    /// The additional vertical space between lines of text.
    public let lineSpacing: CGFloat

    /// The additional horizontal tracking applied between characters.
    public let letterSpacing: CGFloat
    
    /// The recommended starter spacing for readable dyslexia-friendly text.
    public static let defaultSpacing: DyslexicoSpacingSettings = .init(lineSpacing: 1.5, letterSpacing: 0.05)

    /// Creates spacing settings for text and PDF output.
    ///
    /// - Parameters:
    ///   - lineSpacing: Additional vertical space between lines.
    ///   - letterSpacing: Additional horizontal tracking between characters.
    public init(lineSpacing: CGFloat, letterSpacing: CGFloat) {
        self.lineSpacing = lineSpacing
        self.letterSpacing = letterSpacing
    }
}
