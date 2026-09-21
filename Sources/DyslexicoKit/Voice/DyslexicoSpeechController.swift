//
//  DyslexicoSpeechController.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation
import Combine
import AVFoundation

/// A main-actor speech controller that wraps `AVSpeechSynthesizer` for dyslexia-friendly read-aloud experiences.
@MainActor
public final class DyslexicoSpeechController: NSObject, ObservableObject {
    /// The current playback state, suitable for driving SwiftUI controls.
    @Published public private(set) var state: DyslexicoSpeechPlaybackState = .idle

    /// The segment currently being spoken, or `nil` when speech is idle.
    @Published public private(set) var currentSegment: DyslexicoSpeechSegment?

    /// The range currently being spoken within `currentSegment`.
    @Published public private(set) var currentSpeechRange: NSRange?

    /// Called when a queued segment starts speaking.
    public var onSegmentStarted: ((DyslexicoSpeechSegment) -> Void)?

    /// Called when a queued segment finishes speaking.
    public var onSegmentFinished: ((DyslexicoSpeechSegment) -> Void)?

    /// Called as the synthesizer advances through ranges of the current segment.
    public var onWillSpeakRange: ((NSRange, DyslexicoSpeechSegment) -> Void)?

    /// Called when all queued segments finish speaking.
    public var onQueueFinished: (() -> Void)?
    
    /// All voices currently available through Apple's speech synthesizer on this device.
    public nonisolated static var availableVoices: [AVSpeechSynthesisVoice] {
        AVSpeechSynthesisVoice.speechVoices()
    }

    /// Returns available Apple speech voices that exactly match a BCP-47 language code.
    public nonisolated static func availableVoices(for language: String) -> [AVSpeechSynthesisVoice] {
        availableVoices.filter { $0.language == language }
    }

    /// Resolves the best voice for the provided speech settings.
    ///
    /// Voice identifiers win first, then premium voices for the selected language when requested, then the
    /// standard Apple voice for the selected language.
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
    
    /// The speech settings used for newly created utterances.
    public var settings: DyslexicoSpeechSettings
    
    private let synthesizer = AVSpeechSynthesizer()
    private var queuedSegments: [DyslexicoSpeechSegment] = []
    private var currentSegmentIndex: Int?
    private var isStopping = false

    /// Creates a speech controller with the provided settings.
    ///
    /// Keep a strong reference to the controller for as long as speech playback should be available.
    public init(settings: DyslexicoSpeechSettings = .defaultSettings) {
        self.settings = settings
        super.init()
        synthesizer.delegate = self
    }
    
    /// Speaks a single text value.
    ///
    /// Empty or whitespace-only text is ignored.
    public func speak(_ text: String) throws {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        try speak([.init(text: text)])
    }
    
    /// Speaks a queue of text segments in order.
    ///
    /// Empty segments are skipped. Starting a new queue stops any active speech before speaking the new segments.
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

    /// Compatibility overload for clients that prefer a labeled text parameter.
    public func speak(text: String) throws {
        try speak(text)
    }

    /// Compatibility overload for clients that prefer a labeled segments parameter.
    public func speak(segments: [DyslexicoSpeechSegment]) throws {
        try speak(segments)
    }
    
    /// Resumes paused speech playback.
    public func resume() {
        guard state == .paused else { return }
        if synthesizer.continueSpeaking() {
            state = .playing
        }
    }

    /// Pauses active speech at the next word boundary.
    public func pause() {
        guard synthesizer.isSpeaking else { return }
        if synthesizer.pauseSpeaking(at: .word) {
            state = .paused
        }
    }
    
    /// Stops active speech immediately and clears the queued segments.
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
    /// Handles completion from Apple's speech synthesizer and advances the segment queue.
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

    /// Handles cancellation from Apple's speech synthesizer.
    nonisolated public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in
            guard isStopping else { return }
            isStopping = false
        }
    }
    
    /// Publishes the range that Apple's speech synthesizer is about to speak.
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
