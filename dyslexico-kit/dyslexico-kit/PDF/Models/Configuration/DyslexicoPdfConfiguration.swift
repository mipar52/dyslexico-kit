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
    public let style: DyslexicoExportStyle
    public let includeLetterHighlights: Bool
    public let pageSize: DyslexicoPageSize
    
    public static let defaultConfiguration: DyslexicoPdfConfiguration = .init(
        pdfAuthor: "Dyslexico",
        style: .dyslexiaFriendly,
        includeLetterHighlights: true,
        pageSize: .a4)

    public init(
        pdfAuthor: String = "Dyslexico",
        style: DyslexicoExportStyle = .dyslexiaFriendly,
        includeLetterHighlights: Bool = true,
        pageSize: DyslexicoPageSize = .a4
    ) {
        self.pdfAuthor = pdfAuthor
        self.style = style
        self.includeLetterHighlights = includeLetterHighlights
        self.pageSize = pageSize
    }
}

public struct ResolvedStyle {
    public let bodyFont: UIFont
    public let titleFont: UIFont
    public let textColor: UIColor
    public let backgroundColor: UIColor?
    public let lineSpacing: CGFloat
    public let kerning: CGFloat
}

public enum DyslexicoExportStyle {
    case standard, dyslexiaFriendly
}

public enum DyslexicoPageSize {
    case a4, usPaperSize
    
    var size: CGSize {
        switch self {
        case .a4: return CGSize(width: 595.2, height: 841.8) // 210mm × 297mm
        case .usPaperSize: return CGSize(width: 612, height: 792) // 8.5" × 11"
        }
    }
}
