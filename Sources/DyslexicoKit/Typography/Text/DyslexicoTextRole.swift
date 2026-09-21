//
//  DyslexicoTextRole.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import SwiftUI

/// Semantic text roles that let DyslexicoKit size and weight text consistently across views and PDF output.
public enum DyslexicoTextRole {
    /// A larger, bolder role for page titles, section headings, and PDF cover titles.
    case title

    /// The default reading role for paragraphs and main content.
    case body

    /// A smaller role for labels, helper text, validation messages, and metadata.
    case caption

    /// A role tuned for text fields and editors.
    case input

    /// A role tuned for action labels inside buttons.
    case button

    /// The size adjustment applied to the base font size for this role.
    public var sizeOffset: CGFloat {
        switch self {
        case .title:
            return 8
        case .body:
            return 0
        case .caption:
            return -3
        case .input:
            return 0
        case .button:
            return 0
        }
    }
    
    /// The default weight used when neither the global font settings nor the text settings specify one.
    public var defaultWeight: DyslexicoFontWeight {
        switch self {
        case .title:
            return .bold
        case .body:
            return .regular
        case .caption:
            return .light
        case .input:
            return .regular
        case .button:
            return .medium
        }
    }
}
