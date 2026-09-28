//
//  DyslexicoFontRegistrar.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 28.09.2026..
//

import CoreText
import Foundation

enum DyslexicoFontRegistrar {
    private static let lock = NSLock()
    private static var hasRegisteredBundledFonts = false

    static func registerBundledFontsIfNeeded() {
        lock.lock()
        defer { lock.unlock() }

        guard !hasRegisteredBundledFonts else { return }
        hasRegisteredBundledFonts = true

        bundledFontURLs().forEach(registerFont)
    }

    private static func bundledFontURLs() -> [URL] {
        guard let resourceURL = Bundle.module.resourceURL,
              let enumerator = FileManager.default.enumerator(
                at: resourceURL,
                includingPropertiesForKeys: nil
              )
        else {
            return []
        }

        return enumerator
            .compactMap { $0 as? URL }
            .filter { url in
                let fileExtension = url.pathExtension.lowercased()
                return fileExtension == "ttf" || fileExtension == "otf"
            }
    }

    private static func registerFont(at url: URL) {
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
    }
}
