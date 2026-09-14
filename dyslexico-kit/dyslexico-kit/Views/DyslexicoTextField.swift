//
//  DyslexicoTextField.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import SwiftUI

public struct DyslexicoTextField: View {

    @Environment(\.dyslexicoTypography) private var typography

    private let title: LocalizedStringResource?
    private let placeholder: LocalizedStringResource
    private let systemImage: String?
    private let isSecure: Bool
    private let error: LocalizedStringResource?
    private let titleTextSettings: DyslexicoTextSettings
    private let inputTextSettings: DyslexicoTextSettings
    private let errorTextSettings: DyslexicoTextSettings

    private var keyboardType: UIKeyboardType = .default
    private var textContentType: UITextContentType?
    private var autocapitalization: TextInputAutocapitalization = .sentences
    private var autocorrectionDisabled: Bool = true
    private var submitLabel: SubmitLabel = .done
    private var showsClearButton: Bool = true
    private var onSubmit: (() -> Void)?

    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var isPasswordVisible = false


    public init(
        title: LocalizedStringResource? = nil,
        placeholder: LocalizedStringResource,
        systemImage: String? = nil,
        isSecure: Bool = false,
        error: LocalizedStringResource? = nil,
        titleTextSettings: DyslexicoTextSettings = .caption,
        inputTextSettings: DyslexicoTextSettings = .input,
        errorTextSettings: DyslexicoTextSettings = .init(role: .caption, colorOverride: .error),
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        autocapitalization: TextInputAutocapitalization = .sentences,
        autocorrectionDisabled: Bool = true,
        submitLabel: SubmitLabel = .done,
        showsClearButton: Bool = true,
        onSubmit: (() -> Void)? = nil,
        text: Binding<String>
    ) {
        self.title = title
        self.placeholder = placeholder
        self.systemImage = systemImage
        self.isSecure = isSecure
        self.error = error
        self.titleTextSettings = titleTextSettings
        self.inputTextSettings = inputTextSettings
        self.errorTextSettings = errorTextSettings
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
        self.submitLabel = submitLabel
        self.showsClearButton = showsClearButton
        self.onSubmit = onSubmit
        self._text = text
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                DyslexicoText(title, textSettings: titleTextSettings)
            }

            HStack(spacing: 10) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(isFocused ? DyslexicoColors.creamBackgroundColor : DyslexicoColors.darkBackgroundColor)
                        .accessibilityHidden(true)
                }

                field
                    .font(typography.font(for: inputTextSettings))
                    .foregroundStyle(typography.color(for: inputTextSettings))
                    .tracking(typography.spacingSettings.letterSpacing)
                    .lineSpacing(typography.spacingSettings.lineSpacing)
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .textInputAutocapitalization(autocapitalization)
                    .autocorrectionDisabled(autocorrectionDisabled)
                    .submitLabel(submitLabel)
                    .focused($isFocused)
                    .onSubmit {
                        onSubmit?()
                    }

                if isSecure {
                    Button {
                        isPasswordVisible.toggle()
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundStyle(DyslexicoColors.accentPrimary)
                    }
                    .accessibilityLabel(isPasswordVisible ? Text("Hide password") : Text("Show password"))
                    .accessibilityHint(Text("Shows or hides the password."))
                }

                if showsClearButton && !text.isEmpty && !isSecure {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(DyslexicoColors.textSecondary.opacity(0.65))
                    }
                    .accessibilityLabel(Text("Clear text"))
                    .accessibilityHint(Text("Clears the text."))
                }
            }
            .dyslexicoInputChrome(isFocused: isFocused, hasError: error != nil)

            if let error {
                DyslexicoText(error, textSettings: errorTextSettings)
            }
        }
        .animation(.easeOut(duration: 0.15), value: isFocused)
        .animation(.easeOut(duration: 0.15), value: text.isEmpty)
        .accessibilityElement(children: .contain)
    }

    @ViewBuilder
    private var field: some View {
        if isSecure && !isPasswordVisible {
            SecureField("", text: $text, prompt: prompt)
                .accessibilityLabel(Text(title ?? placeholder))
                .accessibilityHint(error.map { Text($0) } ?? Text(""))
        } else {
            TextField("", text: $text, prompt: prompt)
                .accessibilityLabel(Text(title ?? placeholder))
                .accessibilityHint(error.map { Text($0) } ?? Text(""))
        }
    }

    private var prompt: Text {
        Text(placeholder)
            .foregroundColor(DyslexicoColors.textTertiary)
    }

}

private struct DyslexicoTextFieldPreview: View {
    @State private var text = ""

    var body: some View {
        DyslexicoTextField(
            title: "Email",
            placeholder: "name@example.com",
            systemImage: "envelope",
            textContentType: .emailAddress,
            text: $text
        )
        .padding()
    }
}

private struct DyslexicoTextFieldPreviews: PreviewProvider {
    static var previews: some View {
        DyslexicoTextFieldPreview()
    }
}
