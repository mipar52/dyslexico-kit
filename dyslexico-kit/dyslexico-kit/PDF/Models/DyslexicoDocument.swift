//
//  DyslexicoDocument.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

/// Plain text document input used by `DyslexicoPdfGenerator`.
public struct DyslexicoDocument: Codable {
    /// The optional author stored in the generated PDF metadata.
    public let documentAuthor: String?

    /// The document title used in PDF metadata and on the cover page.
    public let title: String

    /// The ordered page contents to export.
    public let pages: [String]
    
    /// Creates a plain text document for PDF export.
    ///
    /// - Parameters:
    ///   - documentAuthor: The optional author stored in PDF metadata.
    ///   - title: The document title.
    ///   - pages: The ordered page text to export.
    public init(documentAuthor: String?, title: String, pages: [String]) {
        self.documentAuthor = documentAuthor
        self.title = title
        self.pages = pages
    }
}
