//
//  DyslexicoViewModifiers.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

/// A view modifier that applies DyslexicoKit font, color, tracking, and line spacing from the environment.
public struct DyslexicoViewModifiers: ViewModifier {
    @Environment(\.dyslexicoTypography) var typography

    let textSettings: DyslexicoTextSettings

    /// Applies the resolved typography settings to the modified content.
    public func body(content: Content) -> some View {
        content
            .font(typography.font(for: textSettings))
            .foregroundStyle(typography.color(for: textSettings))
            .tracking(typography.spacingSettings.letterSpacing)
            .lineSpacing(typography.spacingSettings.lineSpacing)
    }
}

/// A view modifier that gives text inputs consistent DyslexicoKit padding, background, and border states.
public struct DyslexicoInputChromeModifier: ViewModifier {
    let isFocused: Bool
    let hasError: Bool

    /// Creates input chrome for a specific focus and validation state.
    ///
    /// - Parameters:
    ///   - isFocused: Whether the input is currently focused.
    ///   - hasError: Whether the input should show an error border.
    public init(isFocused: Bool, hasError: Bool) {
        self.isFocused = isFocused
        self.hasError = hasError
    }

    /// Applies the input chrome to the modified content.
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

/// A view modifier that applies the current DyslexicoKit readable background color.
public struct DyslexicoReadableBackgroundModifier: ViewModifier {
    @Environment(\.dyslexicoTypography) private var typography

    /// Creates a readable background modifier.
    public init() {}

    /// Applies the readable background color to the modified content.
    public func body(content: Content) -> some View {
        content
            .background(typography.colorSettings.backgroundColor.color)
    }
}
