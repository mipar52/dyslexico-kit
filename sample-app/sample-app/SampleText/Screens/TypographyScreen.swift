//
//  TypographyScreen.swift
//  sample-app
//
//  Created by Milan Parađina on 22.09.2026..
//

import SwiftUI
import DyslexicoKit

struct TypographyScreen: View {
    @State private var selectedFontFamily: DemoFontFamily = .atkinsonHyperlegible
    @State private var fontSize = 24.0
    @State private var lineSpacing = 6.0
    @State private var letterSpacing = 1.2
    @State private var includeBDPair = true
    @State private var includePQPair = true
    @State private var includeMWPair = false
    
    @State private var letterColor: DemoLetterColor = .black
    @State private var backgroundColor: DemoBackgroundColor = .cream

    var body: some View {
        SampleScreenContainer {
            previewSection
            settingsSection
        }
        .navigationTitle("Typography")
    }

    private var previewSection: some View {
        DemoSection(title: "Live Preview", systemImage: "textformat") {
            VStack(alignment: .leading, spacing: 12) {
                DyslexicoText("DyslexicoKit", textSettings: .title)

                DyslexicoText(
                    SampleText.preview,
                    textSettings: .body,
                    layout: .wrap(lines: nil)
                )

                DyslexicoText(
                    "Big dogs and quick puzzles make good preview words.",
                    textSettings: .caption,
                    layout: .wrap(lines: nil)
                )
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(typography.colorSettings.backgroundColor.color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .dyslexicoTypography(typography)
        }
    }

    private var settingsSection: some View {
        DemoSection(title: "Settings", systemImage: "slider.horizontal.3") {
            Picker("Font", selection: $selectedFontFamily) {
                ForEach(DemoFontFamily.allCases) { family in
                    Text(family.title).tag(family)
                }
            }
            .pickerStyle(.segmented)

            DemoSlider(title: "Font size", value: $fontSize, range: 16...34, step: 1, suffix: "pt")
            DemoSlider(title: "Line spacing", value: $lineSpacing, range: 0...14, step: 1, suffix: "pt")
            DemoSlider(title: "Letter spacing", value: $letterSpacing, range: 0...3, step: 0.1, suffix: "pt")
            
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

            Toggle("Highlight b/d", isOn: $includeBDPair)
            Toggle("Highlight p/q", isOn: $includePQPair)
            Toggle("Highlight m/w", isOn: $includeMWPair)
        }
    }

    private var typography: DyslexicoTypographySettings {
        DyslexicoTypographySettings(
            fontSettings: .init(
                family: selectedFontFamily.fontFamily,
                size: fontSize
            ),
            fontHighlightOptions: highlightOptions,
            colorSettings: .init(
                fontColor: letterColor.color,
                backgroundColor: backgroundColor.color
            ),
            spacingSettings: .init(
                lineSpacing: lineSpacing,
                letterSpacing: letterSpacing
            )
        )
    }

    private var highlightOptions: Set<DyslexicoLetterHighlightOption> {
        var options: Set<DyslexicoLetterHighlightOption> = []

        if includeBDPair {
            options.insert(.bdPair)
        }

        if includePQPair {
            options.insert(.pqPair)
        }

        if includeMWPair {
            options.insert(.mwPair)
        }

        return options
    }
}

#Preview {
    NavigationStack {
        TypographyScreen()
    }
}
