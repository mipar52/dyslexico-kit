//
//  DyslexicoSpeechSegment.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation

/// A speakable unit of text used by `DyslexicoSpeechController` queues.
public struct DyslexicoSpeechSegment: Identifiable, Hashable {
    /// A stable identifier for tracking this segment in SwiftUI lists and callbacks.
    public let id: UUID

    /// The text spoken for this segment.
    public let text: String

    /// Creates a speakable text segment.
    ///
    /// - Parameters:
    ///   - id: A stable identifier for the segment.
    ///   - text: The text to speak.
    public init(id: UUID = UUID(), text: String) {
        self.id = id
        self.text = text
    }
}
