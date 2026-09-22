//
//  DyslexicoFontSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import Foundation
import SwiftUI

/// Base font configuration used by typography settings before text-role adjustments are applied.
public struct DyslexicoFontSettings {
    /// The default dyslexia-friendly font configuration used by `DyslexicoTypographySettings.defaultSettings`.
    public static let defaultFont: DyslexicoFontSettings = .init(family: .lexend, size: 24)

    /// The font family used for rendered text.
    public let family: DyslexicoFontFamily

    /// An optional weight override applied before role defaults are considered.
    public let weight: DyslexicoFontWeight?

    /// The base point size used by body text before role offsets are applied.
    public let size: CGFloat

    /// Whether this font should prefer italic variants when available.
    public let isItalic: Bool

    /// Creates a base font configuration.
    ///
    /// - Parameters:
    ///   - family: The font family used for text.
    ///   - weight: An optional weight override for all roles.
    ///   - size: The base point size before text-role offsets are applied.
    ///   - isItalic: Whether italic variants should be preferred.
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
    /// Resolves this configuration into a SwiftUI `Font`.
    public var font: Font {
        DyslexicoFontResolver.font(from: self)
    }
}

extension DyslexicoFontSettings {
    /// Resolves this configuration into a UIKit `UIFont`.
    public var uiFont: UIFont {
        DyslexicoFontResolver.uiFont(from: self)
    }
}
