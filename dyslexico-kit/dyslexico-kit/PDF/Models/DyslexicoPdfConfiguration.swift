//
//  DyslexicoPdfConfiguration.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation
import UIKit

public struct DyslexicoPdfConfiguration {
    public let pdfAuthor: String
    public let style: ExportStyle
    public let includeLetterHighlights: Bool
    public let pageSize: PageSize
    
    static let defaultConfiguration: DyslexicoPdfConfiguration = .init(
        pdfAuthor: "Dyslexico",
        style: .dyslexiaFriendly,
        includeLetterHighlights: true,
        pageSize: .a4)
}

struct ResolvedStyle {
    let bodyFont: UIFont
    let titleFont: UIFont
    let textColor: UIColor
    let backgroundColor: UIColor?
    let lineSpacing: CGFloat
    let kerning: CGFloat
}

public enum ExportStyle {
    case standard, dyslexiaFriendly
}

public enum PageSize {
    case a4, usPaperSize
    
    var size: CGSize {
        switch self {
        case .a4: return CGSize(width: 595.2, height: 841.8) // 210mm × 297mm
        case .usPaperSize: return CGSize(width: 612, height: 792) // 8.5" × 11"
        }
    }
}

public enum ExportError: LocalizedError {
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
