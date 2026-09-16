//
//  DyslexicoSpeechController.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation
import Combine

@MainActor
public final class DyslexicoSpeechController: NSObject, ObservableObject {
    @Published public private(set) var state: DyslexicoSpeechPlaybackState = .idle
    @Published public private(set) var currentSegmentId: DyslexicoSpeechSegment?
    
    public var onSegmentFinished: ((DyslexicoSpeechSegment) -> Void)?
    public var onQueueFinished: (() -> Void)?
    private let settings: DyslexicoSpeechSettings
    
    public init(settings: DyslexicoSpeechSettings = .defaultSettings) {
        self.settings = settings
    }
    
    public func speak(text: String) {}
    public func speak(segments: [DyslexicoSpeechSegment]) {}
    public func resume() {}
    public func pause() {}
    public func stop() {}
    
}
