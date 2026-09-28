//
//  ContentView.swift
//  sample-app
//
//  Created by Milan Parađina on 21.09.2026..
//

import SwiftUI
import DyslexicoKit

private enum NavPath: Hashable {
    case typography
    case views
    case pdf
    case voice
}

struct ContentView: View {
    @State private var navigationPath: [NavPath] = []
    @State private var showsGeneralTypographySettings = false
    @State private var selectedFontFamily: DemoFontFamily = .atkinsonHyperlegible
    @State private var fontSize = 22.0
    @State private var lineSpacing = 6.0
    @State private var letterSpacing = 1.2
    @State private var includeBDPair = true
    @State private var includePQPair = true
    @State private var includeMWPair = false
    @State private var letterColor: DemoLetterColor = .black
    @State private var backgroundColor: DemoBackgroundColor = .cream

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    heroSection
                    navigationSection
                }
                .padding(20)
            }
            .dyslexicoReadableBackground()
            .navigationTitle("DyslexicoKit")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showsGeneralTypographySettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .accessibilityLabel("General typography settings")
                }
            }
            .navigationDestination(for: NavPath.self) { path in
                switch path {
                case .typography:
                    TypographyScreen()
                case .views:
                    ViewsScreen()
                case .pdf:
                    PDFScreen()
                case .voice:
                    VoiceScreen()
                }
            }
        }
        .dyslexicoTypography(globalTypography)
        .sheet(isPresented: $showsGeneralTypographySettings) {
            NavigationStack {
                GeneralTypographySettingsScreen(
                    selectedFontFamily: $selectedFontFamily,
                    fontSize: $fontSize,
                    lineSpacing: $lineSpacing,
                    letterSpacing: $letterSpacing,
                    includeBDPair: $includeBDPair,
                    includePQPair: $includePQPair,
                    includeMWPair: $includeMWPair,
                    letterColor: $letterColor,
                    backgroundColor: $backgroundColor
                )
            }
            .dyslexicoTypography(globalTypography)
        }
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            DyslexicoLabel("SDK sample app", systemImage: "textformat")

            DyslexicoText(
                "DyslexicoKit",
                textSettings: .title,
                layout: .wrap(lines: 2)
            )

            DyslexicoText(
                "Explore the SDK by feature: typography, reusable views, PDF export, and voice playback.",
                textSettings: .body,
                layout: .wrap(lines: nil)
            )
        }
    }

    private var navigationSection: some View {
        VStack(spacing: 12) {
            SampleFeatureCard(
                title: "Typography",
                subtitle: "Tune fonts, spacing, colors, and letter highlights.",
                systemImage: "slider.horizontal.3"
            ) {
                navigationPath.append(.typography)
            }

            SampleFeatureCard(
                title: "Views",
                subtitle: "Preview SDK views and modifiers in a form-like flow.",
                systemImage: "rectangle.stack"
            ) {
                navigationPath.append(.views)
            }

            SampleFeatureCard(
                title: "PDF",
                subtitle: "Generate and share a dyslexia-friendly document.",
                systemImage: "doc.richtext"
            ) {
                navigationPath.append(.pdf)
            }

            SampleFeatureCard(
                title: "Voice",
                subtitle: "Keep speech playback state alive across interactions.",
                systemImage: "speaker.wave.2"
            ) {
                navigationPath.append(.voice)
            }
        }
    }

    private var globalTypography: DyslexicoTypographySettings {
        DyslexicoTypographySettings(
            fontSettings: .init(
                family: selectedFontFamily.fontFamily,
                size: fontSize
            ),
            fontHighlightOptions: globalHighlightOptions,
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

    private var globalHighlightOptions: Set<DyslexicoLetterHighlightOption> {
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
    ContentView()
}
