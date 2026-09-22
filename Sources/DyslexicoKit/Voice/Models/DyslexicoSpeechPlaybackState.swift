//
//  DyslexicoSpeechPlaybackState.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation

/// Playback states published by `DyslexicoSpeechController`.
public enum DyslexicoSpeechPlaybackState: Equatable {
    /// No speech is currently active.
    case idle

    /// Speech is currently playing.
    case playing

    /// Speech is paused and can be resumed.
    case paused
}
