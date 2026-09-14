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

public struct DyslexicoInputChromeModifier: ViewModifier {
    let isFocused: Bool
    let hasError: Bool

    public init(isFocused: Bool, hasError: Bool) {
        self.isFocused = isFocused
        self.hasError = hasError
    }

    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(DyslexicoColors.backgroundElevated)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(borderColor, lineWidth: 1)
            }
    }

    private var borderColor: Color {
        if hasError {
            return DyslexicoColors.semanticError
        }

        if isFocused {
            return DyslexicoColors.accentPrimary.opacity(0.55)
        }

        return DyslexicoColors.borderStrong.opacity(0.35)
    }
}

public struct DyslexicoReadableBackgroundModifier: ViewModifier {
    @Environment(\.dyslexicoTypography) private var typography

    public init() {}

    public func body(content: Content) -> some View {
        content
            .background(typography.colorSettings.backgroundColor.color)
    }
}
