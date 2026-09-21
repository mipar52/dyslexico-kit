//
//  DyslexicoText.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import SwiftUI

/// A SwiftUI text view that automatically applies DyslexicoKit typography from the environment.
public struct DyslexicoText: View {
    @Environment(\.dyslexicoTypography) private var typography

    private let text: Text
    private let accessibilityLabel: String
    
    private let textSettings: DyslexicoTextSettings
    private let layout: DyslexicoTextLayout
    private let alignment: TextAlignment
    
    /// Creates DyslexicoKit text from a plain string.
    ///
    /// - Parameters:
    ///   - text: The text to display.
    ///   - accessibilityLabel: An optional accessibility label. Defaults to the displayed text.
    ///   - textSettings: Role and overrides used to resolve the final typography.
    ///   - layout: Wrapping, truncation, or scaling behavior for the text.
    ///   - alignment: Multiline text alignment.
    public init(
        _ text: String,
        accessibilityLabel: String? = nil,
        textSettings: DyslexicoTextSettings = .body,
        layout: DyslexicoTextLayout = .wrap(lines: nil),
        alignment: TextAlignment = .leading
    ) {
        self.text = Text(text)
        self.accessibilityLabel = accessibilityLabel ?? text
        self.textSettings = textSettings
        self.layout = layout
        self.alignment = alignment
    }

    /// Creates DyslexicoKit text from a localized string resource.
    ///
    /// - Parameters:
    ///   - text: The localized text resource to display.
    ///   - accessibilityLabel: An optional accessibility label. Defaults to the localized text.
    ///   - textSettings: Role and overrides used to resolve the final typography.
    ///   - layout: Wrapping, truncation, or scaling behavior for the text.
    ///   - alignment: Multiline text alignment.
    public init(
        _ text: LocalizedStringResource,
        accessibilityLabel: String? = nil,
        textSettings: DyslexicoTextSettings = .body,
        layout: DyslexicoTextLayout = .wrap(lines: nil),
        alignment: TextAlignment = .leading
    ) {
        self.text = Text(text)
        self.accessibilityLabel = accessibilityLabel ?? String(localized: text)
        self.textSettings = textSettings
        self.layout = layout
        self.alignment = alignment
    }
    
    /// The rendered SwiftUI view.
    public var body: some View {
        text
            .font(typography.font(for: textSettings))
            .foregroundStyle(typography.color(for: textSettings))
            .tracking(typography.spacingSettings.letterSpacing)
            .lineSpacing(typography.spacingSettings.lineSpacing)
            .multilineTextAlignment(alignment)
            .applyDyslexicoTextLayout(layout)
            .accessibilityLabel(accessibilityLabel)
    }
}

private struct DyslexicoTextPreviews: PreviewProvider {
    static var previews: some View {
        DyslexicoText(
            "Sample text",
            textSettings: DyslexicoTextSettings(role: .body),
            layout: .singleLine,
            alignment: .center
        )
    }
}

#Preview {
    DyslexicoTextPreviews.previews
}
