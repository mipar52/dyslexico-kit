//
//  GeneralTypographySettingsScreen.swift
//  sample-app
//
//  Created by Milan Parađina on 28.09.2026..
//

import SwiftUI
import DyslexicoKit

struct GeneralTypographySettingsScreen: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var selectedFontFamily: DemoFontFamily
    @Binding var fontSize: Double
    @Binding var lineSpacing: Double
    @Binding var letterSpacing: Double
    @Binding var includeBDPair: Bool
    @Binding var includePQPair: Bool
    @Binding var includeMWPair: Bool
    @Binding var letterColor: DemoLetterColor
    @Binding var backgroundColor: DemoBackgroundColor

    var body: some View {
        SampleScreenContainer {
            DemoSection(title: "App Preview", systemImage: "textformat") {
                DyslexicoText("Global typography", textSettings: .title)

                DyslexicoText(
                    "These settings are injected at the app root, so SDK views and modifiers inherit them across the sample app.",
                    textSettings: .body,
                    layout: .wrap(lines: nil)
                )
            }

            DemoSection(title: "Font", systemImage: "textformat.size") {
                Picker("Font", selection: $selectedFontFamily) {
                    ForEach(DemoFontFamily.allCases) { family in
                        Text(family.title).tag(family)
                    }
                }
                .pickerStyle(.segmented)

                DemoSlider(title: "Font size", value: $fontSize, range: 16...34, step: 1, suffix: "pt")
                DemoSlider(title: "Line spacing", value: $lineSpacing, range: 0...14, step: 1, suffix: "pt")
                DemoSlider(title: "Letter spacing", value: $letterSpacing, range: 0...3, step: 0.1, suffix: "pt")
            }

            DemoSection(title: "Colors", systemImage: "paintpalette") {
                Picker("Letter color", selection: $letterColor) {
                    ForEach(DemoLetterColor.allCases) { letterColor in
                        Text(letterColor.title).tag(letterColor)
                    }
                }
                .pickerStyle(.segmented)

                Picker("Background color", selection: $backgroundColor) {
                    ForEach(DemoBackgroundColor.allCases) { backgroundColor in
                        Text(backgroundColor.title).tag(backgroundColor)
                    }
                }
                .pickerStyle(.segmented)
            }

            DemoSection(title: "Letter Highlights", systemImage: "highlighter") {
                Toggle("Highlight b/d", isOn: $includeBDPair)
                Toggle("Highlight p/q", isOn: $includePQPair)
                Toggle("Highlight m/w", isOn: $includeMWPair)
            }
        }
        .dyslexicoReadableBackground()
        .navigationTitle("Typography Settings")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GeneralTypographySettingsScreen(
            selectedFontFamily: .constant(.atkinsonHyperlegible),
            fontSize: .constant(22),
            lineSpacing: .constant(6),
            letterSpacing: .constant(1.2),
            includeBDPair: .constant(true),
            includePQPair: .constant(true),
            includeMWPair: .constant(false),
            letterColor: .constant(.black),
            backgroundColor: .constant(.cream)
        )
    }
    .dyslexicoTypography(.defaultSettings)
}
