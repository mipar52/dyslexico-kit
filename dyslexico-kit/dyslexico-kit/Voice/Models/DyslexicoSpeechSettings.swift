//
//  DyslexicoSpeechSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

public struct DyslexicoSpeechSettings: Hashable {
    
    public var speechLanguage: String?
    public var speechRate: Float?
    public var pitchMultiplier: Float?
    public var volume: Float?
    public var prefesPremiumVoice: Bool
    
    public static let defaultSettings: DyslexicoSpeechSettings = .init(
        speechLanguage: "en-US",
        speechRate: 0.46,
        pitchMultiplier: 1.0,
        volume: 1.0,
        prefesPremiumVoice: true
    )
    
    public init(speechLanguage: String? = nil, speechRate: Float? = nil, pitchMultiplier: Float? = nil, volume: Float? = nil, prefesPremiumVoice: Bool) {
        self.speechLanguage = speechLanguage
        self.speechRate = speechRate
        self.pitchMultiplier = pitchMultiplier
        self.volume = volume
        self.prefesPremiumVoice = prefesPremiumVoice
    }
}
