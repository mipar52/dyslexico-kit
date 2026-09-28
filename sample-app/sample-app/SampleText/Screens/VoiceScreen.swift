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
    @Environment(\.dyslexicoTypography) private var typography

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

            DemoSection(title: "Read Along", systemImage: "highlighter") {
                Text(highlightedSpeechText)
                    .lineSpacing(typography.spacingSettings.lineSpacing)
                    .dyslexicoTextLayout(.wrap(lines: nil))
                    .accessibilityLabel(speechText)
                    .animation(.easeOut(duration: 0.12), value: speechController.currentSpeechRange?.location)
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

    private var highlightedSpeechText: AttributedString {
        var attributed = DyslexicoTextUtilities.createStyledAttributedString(
            speechText,
            with: typography,
            role: .body
        )

        guard let currentSpeechRange = speechController.currentSpeechRange,
              let stringRange = Range(currentSpeechRange, in: speechText),
              let lowerBound = AttributedString.Index(stringRange.lowerBound, within: attributed),
              let upperBound = AttributedString.Index(stringRange.upperBound, within: attributed)
        else {
            return attributed
        }

        attributed[lowerBound..<upperBound].backgroundColor = Color(red: 1.0, green: 0.86, blue: 0.34)
        attributed[lowerBound..<upperBound].foregroundColor = Color(red: 0.11, green: 0.13, blue: 0.16)
        return attributed
    }
}

#Preview {
    NavigationStack {
        VoiceScreen()
    }
}
