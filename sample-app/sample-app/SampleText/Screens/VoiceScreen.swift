//
//  VoiceScreen.swift
//  sample-app
//
//  Created by Milan Parađina on 22.09.2026..
//

import SwiftUI
import DyslexicoKit

@MainActor
struct VoiceScreen: View {
    @StateObject private var speechController = DyslexicoSpeechController()
    @State private var speechText = SampleText.note
    @State private var rate = 0.46
    @State private var statusMessage = "Ready"

    var body: some View {
        SampleScreenContainer {
            DemoSection(title: "Speech Text", systemImage: "text.bubble") {
                DyslexicoTextEditor(
                    title: "Text to speak",
                    placeholder: "Write text to speak...",
                    minHeight: 180,
                    text: $speechText
                )
            }

            DemoSection(title: "Playback", systemImage: "speaker.wave.2") {
                DyslexicoText("State: \(speechController.state.sampleTitle)", textSettings: .caption)
                DyslexicoText(statusMessage, textSettings: .caption)

                DemoSlider(title: "Rate", value: $rate, range: 0.35...0.58, step: 0.01, suffix: "")

                HStack(spacing: 12) {
                    DyslexicoButton("Speak", systemImage: "play.fill") {
                        speak()
                    }

                    DyslexicoButton("Stop", systemImage: "stop.fill", variant: .secondary) {
                        speechController.stop()
                        statusMessage = "Speech stopped"
                    }
                }
            }
        }
        .dyslexicoTypography(.defaultSettings)
        .dyslexicoReadableBackground()
        .navigationTitle("Voice")
    }

    private func speak() {
        do {
            speechController.settings = .init(
                language: "en-US",
                rate: Float(rate),
                pitchMultiplier: 1.0,
                volume: 1.0,
                prefersPremiumVoice: true
            )

            try speechController.speak(speechText)
            statusMessage = "Speaking sample text"
        } catch {
            statusMessage = error.localizedDescription
        }
    }
}

#Preview {
    NavigationStack {
        VoiceScreen()
    }
}
