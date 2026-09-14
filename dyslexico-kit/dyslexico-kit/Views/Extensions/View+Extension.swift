//
//  View+Extension.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

public extension View {
    @ViewBuilder
    func applyDyslexicoTextLayout(_ layout: DyslexicoTextLayout) -> some View {
        switch layout {
        case .wrap(let lines):
            self
                .lineLimit(lines)
                .fixedSize(horizontal: false, vertical: true)

        case .singleLine:
            self
                .lineLimit(1)
                .truncationMode(.tail)

        case .scaleToFit(let lines, let minimumScale):
            self
                .lineLimit(lines)
                .minimumScaleFactor(minimumScale)
                .allowsTightening(true)
        }
    }
    
    func dyslexicoText(_ textSettings: DyslexicoTextSettings = .body) -> some View {
        modifier(DyslexicoViewModifiers(textSettings: textSettings))
    }
    
    func dyslexicoText(role: DyslexicoTextRole) -> some View {
        dyslexicoText(DyslexicoTextSettings(role: role))
    }
    
    func dyslexicoText(_ textSettings: DyslexicoTextSettings, typography: DyslexicoTypographySettings) -> some View {
        self
            .font(typography.font(for: textSettings))
            .foregroundStyle(typography.color(for: textSettings))
            .tracking(typography.spacingSettings.letterSpacing)
            .lineSpacing(typography.spacingSettings.lineSpacing)
    }
}

