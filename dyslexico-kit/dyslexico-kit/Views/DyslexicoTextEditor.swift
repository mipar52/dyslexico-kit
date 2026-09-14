//
//  DyslexicoTextEditor.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

public struct DyslexicoTextEditor: View {
    @Environment(\.dyslexicoTypography) private var typography

    private let title: LocalizedStringResource?
    private let placeholder: LocalizedStringResource?
    private let error: LocalizedStringResource?
    private let titleTextSettings: DyslexicoTextSettings
    private let inputTextSettings: DyslexicoTextSettings
    private let errorTextSettings: DyslexicoTextSettings
    private let minHeight: CGFloat

    @Binding private var text: String
    @FocusState private var isFocused: Bool

    public init(
        title: LocalizedStringResource? = nil,
        placeholder: LocalizedStringResource? = nil,
        error: LocalizedStringResource? = nil,
        titleTextSettings: DyslexicoTextSettings = .caption,
        inputTextSettings: DyslexicoTextSettings = .body,
        errorTextSettings: DyslexicoTextSettings = .init(role: .caption, colorOverride: .error),
        minHeight: CGFloat = 140,
        text: Binding<String>
    ) {
        self.title = title
        self.placeholder = placeholder
        self.error = error
        self.titleTextSettings = titleTextSettings
        self.inputTextSettings = inputTextSettings
        self.errorTextSettings = errorTextSettings
        self.minHeight = minHeight
        self._text = text
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                DyslexicoText(title, textSettings: titleTextSettings)
            }

            ZStack(alignment: .topLeading) {
                if text.isEmpty, let placeholder {
                    DyslexicoText(
                        placeholder,
                        textSettings: .init(
                            role: inputTextSettings.role,
                            weightOverride: inputTextSettings.weightOverride,
                            colorOverride: .charcoal,
                            isItalic: inputTextSettings.isItalic
                        )
                    )
                    .opacity(0.55)
                    .padding(.top, 8)
                    .padding(.horizontal, 5)
                    .accessibilityHidden(true)
                }

                TextEditor(text: $text)
                    .font(typography.font(for: inputTextSettings))
                    .foregroundStyle(typography.color(for: inputTextSettings))
                    .tracking(typography.spacingSettings.letterSpacing)
                    .lineSpacing(typography.spacingSettings.lineSpacing)
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: minHeight)
                    .focused($isFocused)
                    .accessibilityLabel(Text(title ?? placeholder ?? "Text"))
                    .accessibilityHint(error.map { Text($0) } ?? Text(""))
            }
            .dyslexicoInputChrome(isFocused: isFocused, hasError: error != nil)

            if let error {
                DyslexicoText(error, textSettings: errorTextSettings)
            }
        }
        .animation(.easeOut(duration: 0.15), value: isFocused)
    }
}

private struct DyslexicoTextEditorPreview: View {
    @State private var text = ""

    var body: some View {
        DyslexicoTextEditor(
            title: "Notes",
            placeholder: "Write something readable...",
            text: $text
        )
        .padding()
    }
}

private struct DyslexicoTextEditorPreviews: PreviewProvider {
    static var previews: some View {
        DyslexicoTextEditorPreview()
    }
}
