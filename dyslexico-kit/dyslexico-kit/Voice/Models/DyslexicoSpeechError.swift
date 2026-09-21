//
//  DyslexicoSpeechError.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 21.09.2026..
//

import Foundation

public enum DyslexicoSpeechError: LocalizedError {
    case audioSessionConfigurationFailed(Error)

    public var errorDescription: String? {
        switch self {
        case .audioSessionConfigurationFailed(let error):
            return "Could not configure the audio session: \(error.localizedDescription)"
        }
    }
}
