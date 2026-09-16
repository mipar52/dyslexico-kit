//
//  DyslexicoPdfDocument.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

public struct DyslexicoPdfDocumentResult {
    public let url: URL
    public let data: Data
    
    public init(url: URL, data: Data) {
        self.url = url
        self.data = data
    }
}
