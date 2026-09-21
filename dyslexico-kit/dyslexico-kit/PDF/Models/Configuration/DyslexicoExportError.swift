//
//  DyslexicoExportError.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation

/// Errors that can occur while exporting a DyslexicoKit PDF.
public enum DyslexicoExportError: LocalizedError {
    /// The document did not contain any non-empty page text.
    case noContentToExport

    /// The generated PDF could not be written to disk.
    case fileWriteFailed

    /// A wrapped lower-level error.
    case underlying(Error)
    
    /// A localized description suitable for displaying in client apps.
    public var errorDescription: String? {
        switch self {
        case .noContentToExport:
            return String(localized: "No content to export")
        case .fileWriteFailed:
            return String(localized: "Could not save PDF!")
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
