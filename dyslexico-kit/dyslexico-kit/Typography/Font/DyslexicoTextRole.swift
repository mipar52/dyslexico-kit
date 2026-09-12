//
//  DyslexicoTextRole.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

public enum DyslexicoTextRole {
    case title
    case body
    case caption
    case input

    var sizeDelta: CGFloat {
        switch self {
        case .title:
            return 
        case .body:
            <#code#>
        case .caption:
            <#code#>
        case .input:
            <#code#>
        }
    }
    var defaultWeight: DyslexicoFontTypeOption { .medium }
}
