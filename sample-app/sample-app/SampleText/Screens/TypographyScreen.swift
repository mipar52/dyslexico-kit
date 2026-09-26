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

    var body: some View {
        SampleScreenContainer {
            DemoSection(title: "Live Preview", systemImage: "textformat") {
                DyslexicoText("DyslexicoKit", textSettings: .title)
                DyslexicoText(SampleText.preview, textSettings: .body, layout: .wrap(lines: nil))
                DyslexicoText("Big dogs and quick puzzles make good preview words.", layout: .wrap(lines: nil))
            }

            settingsSection
        }
        .background(typography.colorSettings.backgroundColor.color)
        .dyslexicoTypography(typography)
        .navigationTitle("Typography")
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
                fontColor: .charcoal,
                backgroundColor: .cream
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
