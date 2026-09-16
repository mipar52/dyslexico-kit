//
//  DyslexicoExportError.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 16.09.2026..
//

import Foundation

public enum DyslexicoExportError: LocalizedError {
    case noContentToExport
    case fileWriteFailed
    case underlying(Error)
    
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
