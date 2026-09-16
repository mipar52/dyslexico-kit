//
//  DyslexicoDocument.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

public struct DyslexicoDocument: Codable {
    public let documentAuthor: String?
    public let title: String
    public let pages: [String]
    
    public init(documentAuthor: String?, title: String, pages: [String]) {
        self.documentAuthor = documentAuthor
        self.title = title
        self.pages = pages
    }
}
