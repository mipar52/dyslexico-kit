//
//  DyslexicoLabel.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

/// A compact icon-and-text label that uses DyslexicoKit typography.
public struct DyslexicoLabel: View {
    private let title: LocalizedStringResource
    private let systemImage: String
    private let textSettings: DyslexicoTextSettings
    private let hidesIconFromAccessibility: Bool

    /// Creates a DyslexicoKit label.
    ///
    /// - Parameters:
    ///   - title: The localized label text.
    ///   - systemImage: The SF Symbol name shown next to the text.
    ///   - textSettings: Role and overrides used to resolve the text typography.
    ///   - hidesIconFromAccessibility: Whether the icon should be hidden from VoiceOver.
    public init(
        _ title: LocalizedStringResource,
        systemImage: String,
        textSettings: DyslexicoTextSettings = .body,
        hidesIconFromAccessibility: Bool = true
    ) {
        self.title = title
        self.systemImage = systemImage
        self.textSettings = textSettings
        self.hidesIconFromAccessibility = hidesIconFromAccessibility
    }

    /// The rendered SwiftUI view.
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(DyslexicoColors.accentPrimary)
                .accessibilityHidden(hidesIconFromAccessibility)

            DyslexicoText(title, textSettings: textSettings)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct DyslexicoLabelPreviews: PreviewProvider {
    static var previews: some View {
        DyslexicoLabel("Reading mode", systemImage: "textformat")
            .padding()
    }
}

#Preview {
    DyslexicoLabelPreviews.previews
}
