//
//  DyslexicoPdfDocument.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

/// The generated PDF result returned by `DyslexicoPdfGenerator`.
public struct DyslexicoPdfDocumentResult {
    /// The temporary file URL where the generated PDF was written.
    public let url: URL

    /// The generated PDF bytes for sharing, uploading, or storing elsewhere.
    public let data: Data
    
    /// Creates a PDF export result.
    ///
    /// - Parameters:
    ///   - url: The file URL for the generated PDF.
    ///   - data: The generated PDF bytes.
    public init(url: URL, data: Data) {
        self.url = url
        self.data = data
    }
}
