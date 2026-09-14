//
//  ViewModifers.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import Foundation
import SwiftUI


// MARK: Napravit Font i UIFont da intiutitivno
/// Npr. Da je Font svoj struct i da on mozda ima metodu za create font i uiFont
/// isto za colors
/// isto za highlights?

extension View {
    func dyslexico(_ typographySettings: DyslexicoTypographySettings) -> some View {
        self
            .font(typographySettings.selectedFont.getFont())
            .foregroundStyle(typographySettings.fontColor.color)
            .foregroundStyle(foregroundStyle ?? role.color(for: prefs))
            .tracking(prefs.increasedLetterSpacing ? 2 : 0)
            .kerning(prefs.increasedLetterSpacing ? 0.6 : 0)
            .multilineTextAlignment(alignment)
            .applyDyslexicoTextLayout(layout)
    }
}
