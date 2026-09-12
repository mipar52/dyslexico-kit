//
//  DyslexicoTextRole.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import SwiftUI

public enum DyslexicoTextRole {
    case title
    case body
    case caption
    case input
    case button

    var sizeOffset: CGFloat {
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
    var defaultWeight: DyslexicoFontTypeOption {
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
