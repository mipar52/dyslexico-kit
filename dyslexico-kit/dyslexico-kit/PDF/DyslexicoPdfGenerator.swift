//
//  DyslexicoPdfGenerator.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation
import UIKit

public struct DyslexicoPdfGenerator {
    
    public func exportToPdf(with document: DyslexicoDocument, pdfConfiguration: DyslexicoPdfConfiguration, typography: DyslexicoTypographySettings) async throws -> (URL, Data) {
        let pages = document.pages.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        guard !pages.isEmpty else { throw ExportError.noContentToExport }
        
        return try await generatePdf(
            document: document,
            pdfConfiguration: pdfConfiguration,
            typography: typography
        )
    }
    
    private func generatePdf(document: DyslexicoDocument, pdfConfiguration: DyslexicoPdfConfiguration, typography: DyslexicoTypographySettings) async throws -> (URL, Data) {
        let style = resolveStyle(pdfConfiguration: pdfConfiguration, typography: typography)
        let pageSize = pdfConfiguration.pageSize.size
        
        let author = document.documentAuthor
        let title = document.title
        let pages = document.pages
        
        let margins = UIEdgeInsets(top: 64, left: 56, bottom: 64, right: 56)
        let contentRect = CGRect(
            x: margins.left,
            y: margins.top,
            width: pageSize.width - margins.left - margins.right,
            height: pageSize.height - margins.top - margins.bottom)
        
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
                
                Self.paintBackground(style: style, pageSize: pageSize, in: cgContext)
                Self.drawCoverPage(
                    title: title,
                    style: style,
                    pageSize: pageSize,
                    contentRect: contentRect,
                    context: cgContext
                )
                
                // PAGES 2+ — Content
                let combinedText = pages.joined(separator: "\n")
                let attributed = DyslexicoPdfUtilties.createStyledNSAttributedString(
                    combinedText,
                    bodyFont: style.bodyFont,
                    textColor: style.textColor,
                    kerning: style.kerning,
                    lineSpacing: style.lineSpacing,
                    highlightOptions: typography.fontHighlightOptions,
                    includeHighlights: pdfConfiguration.includeLetterHighlights
                )
                
                Self.drawContentPages(
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
        return (url, pdfData)
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
            let title = typography.fontSettings.uiFont.withSize(24)
            let body = typography.fontSettings.uiFont
            
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
    
    private nonisolated static func paintBackground(style: ResolvedStyle, pageSize: CGSize, in context: CGContext) {
        guard let backgroundColor = style.backgroundColor else { return }
//        backgroundColor.setFill()
//        UIRectFill(CGRect(origin: .zero, size: pageSize))
        context.saveGState()
        context.setFillColor(backgroundColor.cgColor)
        context.fill(CGRect(origin: .zero, size: pageSize))
        context.restoreGState()
    }
    
    private nonisolated static func drawCoverPage(
        title: String,
        style: ResolvedStyle,
        pageSize: CGSize,
        contentRect: CGRect,
        context: CGContext
    ) {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .left
        titleParagraphStyle.lineBreakMode = .byWordWrapping
        titleParagraphStyle.lineSpacing = 8
        
        let titleAttrs: [NSAttributedString.Key: Any] = [
            .font: style.titleFont,
            .foregroundColor: style.textColor,
            .paragraphStyle: titleParagraphStyle
        ]
        
        let titleString = NSAttributedString(string: title, attributes: titleAttrs)
        
        let framesetter = CTFramesetterCreateWithAttributedString(titleString)
        
        let titleAreaTop = contentRect.minY + (contentRect.height * 0.35)
        let titleAreaHeight: CGFloat = 200
        
        let titleRect = CGRect(
            x: contentRect.minX,
            y: titleAreaTop,
            width: contentRect.width,
            height: titleAreaHeight
        )
        
        let path = CGPath(rect: titleRect, transform: nil)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)

        drawCoreTextFrame(frame, attributed: titleString, in: context, pageSize: pageSize, drawHighlights: true)
    }
    
    private nonisolated static func drawCoreTextFrame(
        _ frame: CTFrame,
        attributed: NSAttributedString,
        in context: CGContext,
        pageSize: CGSize,
        drawHighlights: Bool
    ) {
        context.saveGState()

        context.textMatrix = .identity
        context.translateBy(x: 0, y: pageSize.height)
        context.scaleBy(x: 1, y: -1)
        
        if drawHighlights {
            drawHighlightBackgrounds(frame: frame, attributed: attributed, in: context)
        }

        CTFrameDraw(frame, context)
        
        context.restoreGState()
    }
    
    private nonisolated static func drawContentPages(
        attributed: NSAttributedString,
        style: ResolvedStyle,
        pageSize: CGSize,
        contentRect: CGRect,
        context: UIGraphicsPDFRendererContext
    ) {
        let framesetter = CTFramesetterCreateWithAttributedString(attributed)
        var currentRange = CFRangeMake(0, 0)
        let totalLength = attributed.length
        let cgContext = context.cgContext
        
        while currentRange.location < totalLength {
            context.beginPage()
            
            paintBackground(style: style, pageSize: pageSize, in: cgContext)
            
            let path = CGPath(rect: contentRect, transform: nil)

            let frame = CTFramesetterCreateFrame(framesetter, currentRange, path, nil)

            drawCoreTextFrame(frame, attributed: attributed, in: context.cgContext, pageSize: pageSize, drawHighlights: true)
            
            let visibleRange = CTFrameGetVisibleStringRange(frame)
            guard visibleRange.length > 0 else { break }
            currentRange = CFRangeMake(visibleRange.location + visibleRange.length, 0)
        }
    }
    
    private nonisolated static func drawHighlightBackgrounds(
        frame: CTFrame,
        attributed: NSAttributedString,
        in context: CGContext
    ) {
        let lines = CTFrameGetLines(frame) as! [CTLine]
        var lineOrigins = [CGPoint](repeating: .zero, count: lines.count)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, lines.count), &lineOrigins)
        
        let framePath = CTFrameGetPath(frame)
        let pathBounds = framePath.boundingBox
        
        for (lineIndex, line) in lines.enumerated() {
            let lineOrigin = lineOrigins[lineIndex]
            let runs = CTLineGetGlyphRuns(line) as! [CTRun]
            
            for run in runs {
                let runRange = CTRunGetStringRange(run)
                
                guard runRange.location >= 0,
                      runRange.location < attributed.length,
                      let backgroundColor = attributed.attribute(
                        .dyslexicoHighlightBackground,
                          at: runRange.location,
                          effectiveRange: nil
                      ) as? UIColor
                else { continue }
                
                var ascent: CGFloat = 0
                var descent: CGFloat = 0
                var leading: CGFloat = 0
                let runWidth = CGFloat(CTRunGetTypographicBounds(
                    run,
                    CFRangeMake(0, 0),
                    &ascent,
                    &descent,
                    &leading
                ))
                
                let runXOffset = CTLineGetOffsetForStringIndex(
                    line,
                    runRange.location,
                    nil
                )

                let localRect = CGRect(
                    x: lineOrigin.x + runXOffset,
                    y: lineOrigin.y - descent,
                    width: runWidth,
                    height: ascent + descent
                )
                
                let absoluteRect = CGRect(
                    x: pathBounds.origin.x + localRect.origin.x,
                    y: pathBounds.origin.y + localRect.origin.y,
                    width: localRect.width,
                    height: localRect.height
                )
                
                context.saveGState()
                context.setFillColor(backgroundColor.cgColor)
                context.fill(absoluteRect)
                context.restoreGState()
            }
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
