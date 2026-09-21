//
//  DyslexicoLayout.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

/// Text layout strategies used by `DyslexicoText` and DyslexicoKit text modifiers.
public enum DyslexicoTextLayout {
    /// Allows text to wrap to the provided number of lines, or unlimited lines when `nil`.
    case wrap(lines: Int?)

    /// Keeps text to one line and truncates the tail when needed.
    case singleLine

    /// Allows text to shrink down to a minimum scale factor while respecting a line limit.
    case scaleToFit(lines: Int, minimumScale: CGFloat)
}
