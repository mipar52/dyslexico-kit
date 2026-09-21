//
//  DyslexicoSpeechController.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation
import Combine
import AVFoundation

@MainActor
public final class DyslexicoSpeechController: NSObject, ObservableObject {
    @Published public private(set) var state: DyslexicoSpeechPlaybackState = .idle
    @Published public private(set) var currentSegment: DyslexicoSpeechSegment?
    @Published public private(set) var currentSpeechRange: NSRange?

    public var onSegmentStarted: ((DyslexicoSpeechSegment) -> Void)?
    public var onSegmentFinished: ((DyslexicoSpeechSegment) -> Void)?
    public var onWillSpeakRange: ((NSRange, DyslexicoSpeechSegment) -> Void)?
    public var onQueueFinished: (() -> Void)?
    
    public nonisolated static var availableVoices: [AVSpeechSynthesisVoice] {
        AVSpeechSynthesisVoice.speechVoices()
    }

    public nonisolated static func availableVoices(for language: String) -> [AVSpeechSynthesisVoice] {
        availableVoices.filter { $0.language == language }
    }

    public nonisolated static func defaultVoice(
        for settings: DyslexicoSpeechSettings = .defaultSettings
    ) -> AVSpeechSynthesisVoice? {
        if let voiceIdentifier = settings.voiceIdentifier,
           !voiceIdentifier.isEmpty,
           let voice = AVSpeechSynthesisVoice(identifier: voiceIdentifier) {
            return voice
        }

        let language = settings.language ?? Locale.preferredLanguages.first ?? "en-US"

        if settings.prefersPremiumVoice,
           let premiumVoice = premiumVoice(for: language) {
            return premiumVoice
        }

        return AVSpeechSynthesisVoice(language: language)
            ?? AVSpeechSynthesisVoice(language: "en-US")
    }
    
    public var settings: DyslexicoSpeechSettings
    
    private let synthesizer = AVSpeechSynthesizer()
    private var queuedSegments: [DyslexicoSpeechSegment] = []
    private var currentSegmentIndex: Int?
    private var isStopping = false

    public init(settings: DyslexicoSpeechSettings = .defaultSettings) {
        self.settings = settings
        super.init()
        synthesizer.delegate = self
    }
    
    public func speak(_ text: String) throws {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        try speak([.init(text: text)])
    }
    
    public func speak(_ segments: [DyslexicoSpeechSegment]) throws {
        let readableSegments = segments.filter {
            !$0.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        guard !readableSegments.isEmpty else { return }

        try configureAudioSession()
        stopCurrentSpeechIfNeeded()

        queuedSegments = readableSegments
        currentSegmentIndex = nil
        isStopping = false

        speakNextSegment()
    }

    public func speak(text: String) throws {
        try speak(text)
    }

    public func speak(segments: [DyslexicoSpeechSegment]) throws {
        try speak(segments)
    }
    
    public func resume() {
        guard state == .paused else { return }
        if synthesizer.continueSpeaking() {
            state = .playing
        }
    }

    public func pause() {
        guard synthesizer.isSpeaking else { return }
        if synthesizer.pauseSpeaking(at: .word) {
            state = .paused
        }
    }
    
    public func stop() {
        let wasActive = synthesizer.isSpeaking || state == .paused
        isStopping = wasActive
        queuedSegments.removeAll()
        currentSegmentIndex = nil
        currentSegment = nil
        currentSpeechRange = nil
        synthesizer.stopSpeaking(at: .immediate)
        state = .idle
    }
}

extension DyslexicoSpeechController {
    
    private func configureAudioSession() throws {
        guard settings.configuresAudioSession else { return }
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(
                .playback,
                mode: .spokenAudio,
                policy: .longFormAudio,
                options: [.allowAirPlay]
            )
            try session.setActive(true)
        } catch {
            throw DyslexicoSpeechError.audioSessionConfigurationFailed(error)
        }
    }
    
    private func createSpeechUterance(text: String) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = Self.defaultVoice(for: settings)
        utterance.rate = settings.rate
        utterance.pitchMultiplier = settings.pitchMultiplier
        utterance.volume = settings.volume
        
        return utterance
    }

    private nonisolated static func premiumVoice(for language: String) -> AVSpeechSynthesisVoice? {
        availableVoices.first { voice in
            voice.language == language && voice.quality == .premium
        }
    }

    private func stopCurrentSpeechIfNeeded() {
        guard synthesizer.isSpeaking || state == .paused else { return }
        isStopping = true
        synthesizer.stopSpeaking(at: .immediate)
    }

    private func speakNextSegment() {
        let nextIndex = (currentSegmentIndex ?? -1) + 1

        guard queuedSegments.indices.contains(nextIndex) else {
            finishQueue()
            return
        }

        currentSegmentIndex = nextIndex
        let segment = queuedSegments[nextIndex]
        currentSegment = segment
        currentSpeechRange = nil

        let utterance = createSpeechUterance(text: segment.text)
        synthesizer.speak(utterance)
        state = .playing
        onSegmentStarted?(segment)
    }

    private func finishCurrentSegment() {
        guard let currentSegment else { return }
        onSegmentFinished?(currentSegment)
    }

    private func finishQueue() {
        queuedSegments.removeAll()
        currentSegmentIndex = nil
        currentSegment = nil
        currentSpeechRange = nil
        state = .idle
        onQueueFinished?()
    }
}

extension DyslexicoSpeechController: AVSpeechSynthesizerDelegate {
    nonisolated public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in
            guard !isStopping else {
                isStopping = false
                return
            }

            finishCurrentSegment()
            speakNextSegment()
        }
    }

    nonisolated public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in
            guard isStopping else { return }
            isStopping = false
        }
    }
    
    nonisolated public func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        willSpeakRangeOfSpeechString characterRange: NSRange,
        utterance: AVSpeechUtterance
    ) {
        Task { @MainActor in
            currentSpeechRange = characterRange
            if let currentSegment {
                onWillSpeakRange?(characterRange, currentSegment)
            }
        }
    }
}
