//
//  DyslexicoSpeechSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

public struct DyslexicoSpeechSettings: Hashable {
    
    public var language: String?
    public var voiceIdentifier: String?
    public var rate: Float
    public var pitchMultiplier: Float
    public var volume: Float
    public var prefersPremiumVoice: Bool
    public var configuresAudioSession: Bool
    
    public static let defaultSettings: DyslexicoSpeechSettings = .init(
        language: "en-US",
        voiceIdentifier: nil,
        rate: 0.46,
        pitchMultiplier: 1.0,
        volume: 1.0,
        prefersPremiumVoice: true,
        configuresAudioSession: true
    )
    
    public init(
        language: String? = "en-US",
        voiceIdentifier: String? = nil,
        rate: Float = 0.46,
        pitchMultiplier: Float = 1.0,
        volume: Float = 1.0,
        prefersPremiumVoice: Bool = true,
        configuresAudioSession: Bool = true
    ) {
        self.language = language
        self.voiceIdentifier = voiceIdentifier
        self.rate = rate
        self.pitchMultiplier = pitchMultiplier
        self.volume = volume
        self.prefersPremiumVoice = prefersPremiumVoice
        self.configuresAudioSession = configuresAudioSession
    }
}
