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

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    heroSection
                    navigationSection
                }
                .padding(20)
            }
            .dyslexicoTypography(.defaultSettings)
            .dyslexicoReadableBackground()
            .navigationTitle("DyslexicoKit")
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
}

#Preview {
    ContentView()
}
