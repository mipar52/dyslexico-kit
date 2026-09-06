//
//  DyslexicoFonts.swift
//  dyslexico-ios
//
//  Created by Milan Parađina on 23.04.2026..
//

import SwiftUI

extension Font {
    static func lexend(type: DyslexicoFontOptions, size: CGFloat = 14) -> Font {
        Font.custom("Lexend-\(type.)", size: size)
    }
    
    static func atkinsonHyperlegible(type: DyslexicoFontOptions, size: CGFloat = 14) -> Font {
        Font.custom("AtkinsonHyperlegible-\(type.rawValue)", size: size)
    }
    
    static func openDyslexic(type: DyslexicoFontOptions, size: CGFloat = 14) -> Font {
        Font.custom("OpenDyslexic-\(type.rawValue)", size: size)
    }
}

extension UIFont {
    
}
