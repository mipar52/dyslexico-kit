//
//  DyslexicoFontOptions.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 06.09.2026..
//

import SwiftUI

enum DyslexicoFontOptions {
    case openDyslexic
    case atkinsonHyperlegible
    case lexend
    case systemDefault
    
    var fontName: String {
        switch self {
        case .openDyslexic:
            return "OpenDyslexic"
        case .atkinsonHyperlegible:
            return "AtkinsonHyperlegible"
        case .lexend:
            return "Lexend"
        default:
            return "System"
        }
    }
    
    func font(type: DyslexicoFontOptions, size: CGFloat = 14) -> Font {
        switch self {
        case .openDyslexic:
            return .openDyslexic(type: type, size: size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(type: type, size: size)
        case .lexend:
            return .lexend(type: type, size: size)
        default:
            return .system(size: size)
        }
    }
    
    func customFont(name: String, type: String, size: CGFloat) -> Font {
        return .dyslexicoCustom(name: name, type: type, size: size)
    }
    
    func uiFont(type: DyslexicoFontTypeOption, size: CGFloat = 14) -> UIFont {
        switch self {
        case .openDyslexic:
            return .openDyslexic(type: type, size: size)
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible(type: type, size: size)
        case .lexend:
            return .lexend(type: type, size: size)
        default:
            return .systemFont(ofSize: size)
        }
    }
    
    func customUiFont(name: String, type: String, size: CGFloat) -> UIFont {
        return .dyslexicoCustom(name: name, type: type, size: size)
    }
}


extension Font {
    static func lexend(type: DyslexicoFontTypeOption, size: CGFloat = 14) -> Font {
        Font.custom("Lexend-\(type.rawValue)", size: size)
    }
    
    static func atkinsonHyperlegible(type: DyslexicoFontTypeOption, size: CGFloat = 14) -> Font {
        Font.custom("AtkinsonHyperlegible-\(type.rawValue)", size: size)
    }
    
    static func openDyslexic(type: DyslexicoFontTypeOption, size: CGFloat = 14) -> Font {
        Font.custom("OpenDyslexic-\(type.rawValue)", size: size)
    }
    
    static func dyslexicoCustom(name: String, type: String, size: CGFloat = 14) -> Font {
        Font.custom("\(name)-\(type)", size: size)
    }
}

extension UIFont {
    static func lexend(type: DyslexicoFontTypeOption, size: CGFloat = 14) -> UIFont {
        if let font = UIFont(name: "Lexend-\(type.rawValue)", size: size) {
            return font
        }
        return .systemFont(ofSize: size)
    }
    
    static func atkinsonHyperlegible(type: DyslexicoFontTypeOption, size: CGFloat = 14) -> UIFont {
        if let font =  UIFont(name: "AtkinsonHyperlegible-\(type.rawValue)", size: size) {
            return font
        }
        return .systemFont(ofSize: size)
    }
    
    static func openDyslexic(type: DyslexicoFontTypeOption, size: CGFloat = 14) -> UIFont {
        if let font = UIFont(name:"OpenDyslexic-\(type.rawValue)", size: size) { return font }
        return .systemFont(ofSize: size)

    }
    
    static func dyslexicoCustom(name: String, type: String, size: CGFloat = 14) -> UIFont {
        if let font = UIFont(name:"\(name)-\(type)", size: size) { return font }
        return .systemFont(ofSize: size)
    }
}
