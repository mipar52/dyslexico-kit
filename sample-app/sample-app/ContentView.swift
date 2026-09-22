//
//  ContentView.swift
//  sample-app
//
//  Created by Milan Parađina on 21.09.2026..
//

import SwiftUI
import DyslexicoKit

struct ContentView: View {
    let settings = DyslexicoTypographySettings(
        fontSettings: .init(family: .openDyslexic, size: 24),
        fontHighlightOptions: [.bdPair, .mwPair],
        colorSettings: .init(fontColor: .charcoal, backgroundColor: .cream), spacingSettings: .init(lineSpacing: 3, letterSpacing: 2))
    
    var body: some View {
        VStack {
           DyslexicoText("Lorem ipsum! Lorem ipsum! Lorem ipsum! Lorem ipsum!")
                .applyDyslexicoTextLayout(.singleLine)
            
            Button("Button") {
                do {
                    let speech = DyslexicoSpeechController(
                        settings: .init(
                            language: "en-US",
                            rate: 0.46,
                            pitchMultiplier: 1.0,
                            volume: 1.0,
                            prefersPremiumVoice: true
                        )
                    )

                    try speech.speak("Readable text for this user.")
                } catch {
                    print(error.localizedDescription)
                }

            }
                
        }
        .dyslexicoTypography(settings)
        .padding()
    }
}

#Preview {
    ContentView()
}
