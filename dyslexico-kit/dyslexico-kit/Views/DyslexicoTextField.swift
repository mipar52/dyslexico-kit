//
//  DyslexicoTextField.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import SwiftUI

struct DyslexicoTextField: View {

    let title: LocalizedStringResource?
    let placeholder: LocalizedStringResource
    let systemImage: String?
    let isSecure: Bool
    let error: LocalizedStringResource?

    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?
    var autocapitalization: TextInputAutocapitalization = .sentences
    var autocorrectionDisabled: Bool = true
    var submitLabel: SubmitLabel = .done
    var showsClearButton: Bool = true
    var onSubmit: (() -> Void)?

    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var isPasswordVisible = false


    init(
        title: LocalizedStringResource? = nil,
        placeholder: LocalizedStringResource,
        systemImage: String? = nil,
        isSecure: Bool = false,
        error: LocalizedStringResource? = nil,
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
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
        self.submitLabel = submitLabel
        self.showsClearButton = showsClearButton
        self.onSubmit = onSubmit
        self._text = text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title {
                DyslexicoText(
                    text: title,
                    role: .caption,
                    type: .bold,
                    foregroundStyle: DyslexicoColors.textSecondary
                )
            }

            HStack(spacing: 10) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(isFocused ? DyslexicoColors.accentPrimary : DyslexicoColors.textSecondary)
                        .accessibilityHidden(true)
                }

                field
                    .font(prefs.selectedFont.font(size: prefs.fontSize, type: .regular))
                    .foregroundStyle(prefs.selectedTextColor.color)
                    .tracking(prefs.increasedLetterSpacing ? 2 : 0)
                    .kerning(prefs.increasedLetterSpacing ? 0.6 : 0)
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
                    .accessibilityLabel(isPasswordVisible ? .accessibilityHidePassword : .accessibilityShowPassword)
                }

                if showsClearButton && !text.isEmpty && !isSecure {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(DyslexicoColors.textSecondary.opacity(0.65))
                    }
                    .accessibilityLabel(.accessibilityClearText)
                }
            }
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

            if let error {
                DyslexicoText(
                    text: error,
                    role: .caption,
                    foregroundStyle: DyslexicoColors.semanticError
                )
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
        } else {
            TextField("", text: $text, prompt: prompt)
                .accessibilityLabel(Text(title ?? placeholder))
        }
    }

    private var prompt: Text {
        Text(placeholder)
            .foregroundColor(DyslexicoColors.textTertiary)
    }

    private var borderColor: Color {
        if error != nil {
            return DyslexicoColors.semanticError
        }

        if isFocused {
            return DyslexicoColors.accentPrimary.opacity(0.55)
        }

        return DyslexicoColors.borderStrong.opacity(0.35)
    }
}

#Preview {
    DyslexicoTextField()
}
