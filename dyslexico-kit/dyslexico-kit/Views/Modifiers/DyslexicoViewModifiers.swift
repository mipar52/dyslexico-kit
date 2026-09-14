//
//  DyslexicoViewModifiers.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

public struct DyslexicoViewModifiers: ViewModifier {
    @Environment(\.dyslexicoTypography) var typography

    let textSettings: DyslexicoTextSettings

    public func body(content: Content) -> some View {
        content
            .font(typography.font(for: textSettings))
            .foregroundStyle(typography.color(for: textSettings))
            .tracking(typography.spacingSettings.letterSpacing)
            .lineSpacing(typography.spacingSettings.lineSpacing)
    }
}
