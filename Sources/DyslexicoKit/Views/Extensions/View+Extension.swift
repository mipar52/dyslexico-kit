//
//  View+Extension.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

/// Convenience modifiers for applying DyslexicoKit typography and layout to any SwiftUI view.
public extension View {
    /// Applies one of DyslexicoKit's predefined text layout behaviors.
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
    
    /// Styles this view as DyslexicoKit text using typography from the SwiftUI environment.
    ///
    /// Use this when you want to keep a native SwiftUI `Text`, `Label`, or custom view instead of using
    /// `DyslexicoText` directly.
    func dyslexicoText(_ textSettings: DyslexicoTextSettings = .body) -> some View {
        modifier(DyslexicoViewModifiers(textSettings: textSettings))
    }
    
    /// Styles this view as DyslexicoKit text for a semantic role.
    func dyslexicoText(role: DyslexicoTextRole) -> some View {
        dyslexicoText(DyslexicoTextSettings(role: role))
    }
    
    /// Styles this view as DyslexicoKit text using an explicit typography configuration.
    ///
    /// Use this overload when the typography should not come from the SwiftUI environment.
    func dyslexicoText(_ textSettings: DyslexicoTextSettings, typography: DyslexicoTypographySettings) -> some View {
        self
            .font(typography.font(for: textSettings))
            .foregroundStyle(typography.color(for: textSettings))
            .tracking(typography.spacingSettings.letterSpacing)
            .lineSpacing(typography.spacingSettings.lineSpacing)
    }

    /// Applies a DyslexicoKit text layout behavior.
    func dyslexicoTextLayout(_ layout: DyslexicoTextLayout) -> some View {
        applyDyslexicoTextLayout(layout)
    }

    /// Applies DyslexicoKit input chrome for focus and validation states.
    func dyslexicoInputChrome(isFocused: Bool, hasError: Bool) -> some View {
        modifier(DyslexicoInputChromeModifier(isFocused: isFocused, hasError: hasError))
    }

    /// Applies the current DyslexicoKit readable background color behind this view.
    func dyslexicoReadableBackground() -> some View {
        modifier(DyslexicoReadableBackgroundModifier())
    }
}
