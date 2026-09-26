//
//  ViewsScreen.swift
//  sample-app
//
//  Created by Milan Parađina on 22.09.2026..
//

import SwiftUI
import DyslexicoKit

struct ViewsScreen: View {
    @State private var email = ""
    @State private var noteText = SampleText.note
    @State private var statusMessage = "Ready"

    var body: some View {
        SampleScreenContainer {
            DemoSection(title: "SDK Views", systemImage: "rectangle.stack") {
                DyslexicoText("Reusable views inherit typography from the environment.")

                DyslexicoTextField(
                    title: "Email",
                    placeholder: "name@example.com",
                    systemImage: "envelope",
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    autocapitalization: .never,
                    text: $email
                )

                DyslexicoTextEditor(
                    title: "Reading note",
                    placeholder: "Write a short sample...",
                    minHeight: 150,
                    text: $noteText
                )

                DyslexicoButton("Primary action", systemImage: "checkmark") {
                    statusMessage = "Button tapped"
                }

                DyslexicoButton("Secondary action", systemImage: "sparkles", variant: .secondary) {
                    statusMessage = "Secondary action tapped"
                }

                DyslexicoText(statusMessage, textSettings: .caption)
            }

            DemoSection(title: "View Modifiers", systemImage: "wand.and.stars") {
                Text("This is native SwiftUI Text styled with .dyslexicoText(role:).")
                    .dyslexicoText(role: .body)
                    .dyslexicoTextLayout(.wrap(lines: nil))

                Text("Custom title modifier")
                    .dyslexicoText(.init(role: .title, weightOverride: .semiBold))
                    .dyslexicoTextLayout(.singleLine)
            }

            DemoSection(title: "Attributed String", systemImage: "text.quote") {
                Text(
                    DyslexicoTextUtilities.createStyledAttributedString(
                        "Custom views can receive a SwiftUI AttributedString.",
                        with: .defaultSettings,
                        role: .body
                    )
                )
                .dyslexicoTextLayout(.wrap(lines: nil))
            }
        }
        .dyslexicoTypography(.defaultSettings)
        .dyslexicoReadableBackground()
        .navigationTitle("Views")
    }
}

#Preview {
    NavigationStack {
        ViewsScreen()
    }
}
