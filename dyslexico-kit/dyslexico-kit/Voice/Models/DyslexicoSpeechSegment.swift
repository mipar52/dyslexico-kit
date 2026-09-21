//
//  DyslexicoSpeechSegment.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation

public struct DyslexicoSpeechSegment: Identifiable, Hashable {
    public let id: UUID
    public let text: String

    public init(id: UUID = UUID(), text: String) {
        self.id = id
        self.text = text
    }
}
