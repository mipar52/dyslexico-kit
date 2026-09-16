//
//  DyslexicoPdfGenerator.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation
import UIKit

public struct DyslexicoPdfGenerator {
    
    public func exportToPdf(with document: DyslexicoDocument, pdfConfiguration: DyslexicoPdfConfiguration, typography: DyslexicoTypographySettings) async throws -> DyslexicoPdfDocumentResult {
        let pages = document.pages.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        guard !pages.isEmpty else { throw DyslexicoExportError.noContentToExport }
        
        let filteredDocument: DyslexicoDocument = .init(
            documentAuthor: document.documentAuthor,
            title: document.title,
            pages: pages)
        
        return try await generatePdf(
            document: filteredDocument,
            pdfConfiguration: pdfConfiguration,
            typography: typography
        )
    }
    
    private func generatePdf(document: DyslexicoDocument, pdfConfiguration: DyslexicoPdfConfiguration, typography: DyslexicoTypographySettings) async throws -> DyslexicoPdfDocumentResult {
        // step 1. get the style and the data
        let style = resolveStyle(pdfConfiguration: pdfConfiguration, typography: typography)
        let pageSize = pdfConfiguration.pageSize.size
        
        let author = document.documentAuthor
        let title = document.title
        let pages = document.pages
        
        // step 2. create the page layout contraints
        let margins = UIEdgeInsets(top: 64, left: 56, bottom: 64, right: 56)
        let contentRect = CGRect(
            x: margins.left,
            y: margins.top,
            width: pageSize.width - margins.left - margins.right,
            height: pageSize.height - margins.top - margins.bottom)
        
        // step 3. add the information to the pdf
        let pdfData = await Task.detached(priority: .userInitiated) { () -> Data in
            let format = UIGraphicsPDFRendererFormat()
            format.documentInfo = [
                kCGPDFContextTitle as String: title,
                kCGPDFContextCreator as String: author
            ]
            
            let renderer = UIGraphicsPDFRenderer(
                bounds: CGRect(origin: .zero, size: pageSize),
                format: format
            )
            
            return renderer.pdfData { context in
                // PAGE 1 — Cover page
                context.beginPage()
                let cgContext = context.cgContext
                
                // step 1. paint the pdf background
                DyslexicoPdfGeneratorUtilities.paintBackground(style: style, pageSize: pageSize, in: cgContext)
                
                // step 2. draw the cover page
                DyslexicoPdfGeneratorUtilities.drawCoverPage(
                    title: title,
                    style: style,
                    pageSize: pageSize,
                    contentRect: contentRect,
                    context: cgContext
                )
                
                // PAGES 2+ — Content
                let combinedText = pages.joined(separator: "\n")
                
                // step 3. modify the text with the defined typography settings
                let attributed = DyslexicoTextUtilities.createStyledNSAttributedString(
                    combinedText,
                    bodyFont: style.bodyFont,
                    textColor: style.textColor,
                    kerning: style.kerning,
                    lineSpacing: style.lineSpacing,
                    highlightOptions: typography.fontHighlightOptions,
                    includeHighlights: pdfConfiguration.includeLetterHighlights
                )
                // step 4. insert the styled text and draw them to the rest of the pages
                DyslexicoPdfGeneratorUtilities.drawContentPages(
                    attributed: attributed,
                    style: style,
                    pageSize: pageSize,
                    contentRect: contentRect,
                    context: context
                )
            }
        }.value
        
        let filename = sanitizeFilename(title)
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(filename)
            .appendingPathExtension("pdf")
        
        try pdfData.write(to: url, options: .atomic)
        return DyslexicoPdfDocumentResult(url: url, data: pdfData)
    }
    
    private func resolveStyle(pdfConfiguration: DyslexicoPdfConfiguration, typography: DyslexicoTypographySettings) -> ResolvedStyle {
        switch pdfConfiguration.style {
        case .standard:
             return ResolvedStyle(
                bodyFont: UIFont(name: "Helvetica", size: 12) ?? .systemFont(ofSize: 12),
                titleFont: UIFont(name: "Helvetica-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
                textColor: .black,
                backgroundColor: nil,
                lineSpacing: 4,
                kerning: 0
            )
        case .dyslexiaFriendly:
            let title = typography.uiFont(for: DyslexicoTextRole.title)
            let body = typography.uiFont(for: DyslexicoTextRole.body)
            
            return ResolvedStyle(
                bodyFont: body,
                titleFont: title,
                textColor: typography.colorSettings.fontColor.uiColor,
                backgroundColor: typography.colorSettings.backgroundColor.uiColor,
                lineSpacing: typography.spacingSettings.lineSpacing,
                kerning: typography.spacingSettings.letterSpacing
            )
        }
    }
    
    private func sanitizeFilename(_ title: String) -> String {
        let invalidCharacters = CharacterSet(charactersIn: "/\\:?\"<>|*")
        let sanitized = title.components(separatedBy: invalidCharacters).joined()
        let trimmed = sanitized.trimmingCharacters(in: .whitespacesAndNewlines)
        let replaceWhitespaces = trimmed.replacingOccurrences(of: " ", with: "-")
        return replaceWhitespaces.isEmpty ? "document" : replaceWhitespaces
    }
}
