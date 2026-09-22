//
//  Font+Extension.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

extension Font {
    static func lexend(weight: DyslexicoFontWeight, size: CGFloat = 14) -> Font {
        Font.custom("Lexend-\(weight.rawValue)", size: size)
    }
    
    static func atkinsonHyperlegible(weight: DyslexicoFontWeight, size: CGFloat = 14) -> Font {
        Font.custom("AtkinsonHyperlegible-\(weight.rawValue)", size: size)
    }
    
    static func openDyslexic(weight: DyslexicoFontWeight, size: CGFloat = 14) -> Font {
        Font.custom("OpenDyslexic-\(weight.rawValue)", size: size)
    }
    
    static func dyslexicoCustom(name: String, weight: String, size: CGFloat = 14) -> Font {
        Font.custom("\(name)-\(weight)", size: size)
    }
}

extension UIFont {
    static func lexend(weight: DyslexicoFontWeight, size: CGFloat = 14) -> UIFont {
        if let font = UIFont(name: "Lexend-\(weight.rawValue)", size: size) {
            return font
        }
        return .systemFont(ofSize: size)
    }
    
    static func atkinsonHyperlegible(weight: DyslexicoFontWeight, size: CGFloat = 14) -> UIFont {
        if let font =  UIFont(name: "AtkinsonHyperlegible-\(weight.rawValue)", size: size) {
            return font
        }
        return .systemFont(ofSize: size)
    }
    
    static func openDyslexic(weight: DyslexicoFontWeight, size: CGFloat = 14) -> UIFont {
        if let font = UIFont(name:"OpenDyslexic-\(weight.rawValue)", size: size) { return font }
        return .systemFont(ofSize: size)

    }
    
    static func dyslexicoCustom(name: String, weight: String, size: CGFloat = 14) -> UIFont {
        if let font = UIFont(name:"\(name)-\(weight)", size: size) { return font }
        return .systemFont(ofSize: size)
    }
}
