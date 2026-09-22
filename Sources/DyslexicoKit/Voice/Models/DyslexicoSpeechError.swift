//
//  DyslexicoSpeechError.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 21.09.2026..
//

import Foundation

/// Errors that can occur while preparing speech playback.
public enum DyslexicoSpeechError: LocalizedError {
    /// The controller could not configure `AVAudioSession`.
    case audioSessionConfigurationFailed(Error)

    /// A localized description suitable for displaying in client apps.
    public var errorDescription: String? {
        switch self {
        case .audioSessionConfigurationFailed(let error):
            return "Could not configure the audio session: \(error.localizedDescription)"
        }
    }
}
