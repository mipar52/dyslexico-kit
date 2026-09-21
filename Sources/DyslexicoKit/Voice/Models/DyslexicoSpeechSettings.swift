//
//  DyslexicoSpeechSettings.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

/// Configuration for DyslexicoKit text-to-speech playback.
public struct DyslexicoSpeechSettings: Hashable {
    
    /// The preferred BCP-47 language code, such as `en-US` or `hr-HR`.
    public var language: String?

    /// An optional exact Apple voice identifier selected by the client app.
    public var voiceIdentifier: String?

    /// The speech rate passed to `AVSpeechUtterance`.
    public var rate: Float

    /// The pitch multiplier passed to `AVSpeechUtterance`.
    public var pitchMultiplier: Float

    /// The output volume passed to `AVSpeechUtterance`.
    public var volume: Float

    /// Whether voice resolution should prefer Apple's premium voice for the selected language when available.
    public var prefersPremiumVoice: Bool

    /// Whether the controller should configure `AVAudioSession` before speaking.
    public var configuresAudioSession: Bool
    
    /// The recommended default speech settings for a readable spoken pace.
    public static let defaultSettings: DyslexicoSpeechSettings = .init(
        language: "en-US",
        voiceIdentifier: nil,
        rate: 0.46,
        pitchMultiplier: 1.0,
        volume: 1.0,
        prefersPremiumVoice: true,
        configuresAudioSession: true
    )
    
    /// Creates speech playback settings.
    ///
    /// - Parameters:
    ///   - language: The preferred BCP-47 language code.
    ///   - voiceIdentifier: An optional exact Apple voice identifier.
    ///   - rate: The speech rate passed to `AVSpeechUtterance`.
    ///   - pitchMultiplier: The pitch multiplier passed to `AVSpeechUtterance`.
    ///   - volume: The output volume passed to `AVSpeechUtterance`.
    ///   - prefersPremiumVoice: Whether to prefer Apple's premium voice when available.
    ///   - configuresAudioSession: Whether the controller should configure `AVAudioSession` before speaking.
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
