//
//  DyslexicoPdfConfiguration.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation
import UIKit

/// Options that control how `DyslexicoPdfGenerator` exports a document.
public struct DyslexicoPdfConfiguration {
    /// The creator value stored in the generated PDF metadata.
    public let pdfAuthor: String

    /// The visual export style used for the generated PDF.
    public let style: DyslexicoExportStyle

    /// Whether letter-pair highlights should be drawn in dyslexia-friendly PDFs.
    public let includeLetterHighlights: Bool

    /// The page size used by the generated PDF.
    public let pageSize: DyslexicoPageSize
    
    /// The recommended default PDF export configuration.
    public static let defaultConfiguration: DyslexicoPdfConfiguration = .init(
        pdfAuthor: "Dyslexico",
        style: .dyslexiaFriendly,
        includeLetterHighlights: true,
        pageSize: .a4)

    /// Creates PDF export configuration.
    ///
    /// - Parameters:
    ///   - pdfAuthor: The creator value stored in PDF metadata.
    ///   - style: The visual export style.
    ///   - includeLetterHighlights: Whether dyslexia-friendly exports should include letter-pair highlights.
    ///   - pageSize: The page size used by the generated PDF.
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

/// Concrete drawing style resolved from PDF configuration and typography settings.
public struct ResolvedStyle {
    /// The body font used for document pages.
    public let bodyFont: UIFont

    /// The title font used for the cover page.
    public let titleFont: UIFont

    /// The text color used throughout the PDF.
    public let textColor: UIColor

    /// The optional background color painted behind PDF pages.
    public let backgroundColor: UIColor?

    /// The paragraph line spacing used for PDF text.
    public let lineSpacing: CGFloat

    /// The character spacing used for PDF text.
    public let kerning: CGFloat
}

/// Visual style options for generated PDFs.
public enum DyslexicoExportStyle {
    /// A plain PDF style that uses standard Helvetica fonts and no readable background.
    case standard

    /// A dyslexia-friendly PDF style resolved from `DyslexicoTypographySettings`.
    case dyslexiaFriendly
}

/// Page sizes supported by `DyslexicoPdfGenerator`.
public enum DyslexicoPageSize {
    /// A4 page size.
    case a4

    /// US Letter page size.
    case usPaperSize
    
    var size: CGSize {
        switch self {
        case .a4: return CGSize(width: 595.2, height: 841.8) // 210mm × 297mm
        case .usPaperSize: return CGSize(width: 612, height: 792) // 8.5" × 11"
        }
    }
}
