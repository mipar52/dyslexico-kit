//
//  PDFScreen.swift
//  sample-app
//
//  Created by Milan Parađina on 22.09.2026..
//

import SwiftUI
import DyslexicoKit

@MainActor
struct PDFScreen: View {
    @Environment(\.dyslexicoTypography) private var typography

    @State private var documentText = SampleText.longForm
    @State private var includeHighlights = true
    @State private var selectedExportStyle: SampleExportStyle = .dyslexiaFriendly
    @State private var pdfURL: URL?
    @State private var statusMessage = "Ready"
    @State private var hasSeededPDFTypography = false
    @State private var selectedPDFFontFamily: DemoFontFamily = .atkinsonHyperlegible
    @State private var pdfFontSize = 22.0
    @State private var pdfLineSpacing = 6.0
    @State private var pdfLetterSpacing = 1.2
    @State private var includePDFBDPair = true
    @State private var includePDFPQPair = true
    @State private var includePDFMWPair = false
    @State private var pdfLetterColor: DemoLetterColor = .black
    @State private var pdfBackgroundColor: DemoBackgroundColor = .cream

    var body: some View {
        SampleScreenContainer {
            DemoSection(title: "Document", systemImage: "doc.text") {
                DyslexicoTextEditor(
                    title: "PDF text",
                    placeholder: "Write text for the PDF...",
                    minHeight: 220,
                    text: $documentText
                )
            }

            pdfTypographySection

            DemoSection(title: "Export Options", systemImage: "gearshape") {
                Toggle("Include letter highlights", isOn: $includeHighlights)

                Picker("Style", selection: $selectedExportStyle) {
                    ForEach(SampleExportStyle.allCases) { style in
                        Text(style.title).tag(style)
                    }
                }
                .pickerStyle(.segmented)

                DyslexicoButton("Generate PDF", systemImage: "doc.badge.plus") {
                    Task {
                        await generatePDF()
                    }
                }

                DyslexicoText(statusMessage, textSettings: .caption)

                if let pdfURL {
                    ShareLink(item: pdfURL) {
                        Label("Share generated PDF", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .dyslexicoReadableBackground()
        .navigationTitle("PDF")
        .onAppear {
            guard !hasSeededPDFTypography else { return }
            seedPDFTypography(from: typography)
            hasSeededPDFTypography = true
        }
    }

    private var pdfTypographySection: some View {
        DemoSection(title: "PDF Typography", systemImage: "textformat.size") {
            DyslexicoText(
                "PDF exports can use their own reader settings. They start from the app settings, but changing these controls only affects generated PDFs.",
                textSettings: .caption,
                layout: .wrap(lines: nil)
            )

            DyslexicoButton("Use app settings", systemImage: "arrow.clockwise", variant: .secondary) {
                seedPDFTypography(from: typography)
            }

            VStack(alignment: .leading, spacing: 10) {
                DyslexicoText("PDF preview", textSettings: .title)

                DyslexicoText(
                    "Generated PDFs will use these typography settings.",
                    textSettings: .body,
                    layout: .wrap(lines: nil)
                )
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(pdfTypography.colorSettings.backgroundColor.color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .dyslexicoTypography(pdfTypography)

            Picker("Font", selection: $selectedPDFFontFamily) {
                ForEach(DemoFontFamily.allCases) { family in
                    Text(family.title).tag(family)
                }
            }
            .pickerStyle(.segmented)

            DemoSlider(title: "Font size", value: $pdfFontSize, range: 16...34, step: 1, suffix: "pt")
            DemoSlider(title: "Line spacing", value: $pdfLineSpacing, range: 0...14, step: 1, suffix: "pt")
            DemoSlider(title: "Letter spacing", value: $pdfLetterSpacing, range: 0...3, step: 0.1, suffix: "pt")

            Picker("Letter color", selection: $pdfLetterColor) {
                ForEach(DemoLetterColor.allCases) { letterColor in
                    Text(letterColor.title).tag(letterColor)
                }
            }
            .pickerStyle(.segmented)

            Picker("Background color", selection: $pdfBackgroundColor) {
                ForEach(DemoBackgroundColor.allCases) { backgroundColor in
                    Text(backgroundColor.title).tag(backgroundColor)
                }
            }
            .pickerStyle(.segmented)

            Toggle("Highlight b/d", isOn: $includePDFBDPair)
            Toggle("Highlight p/q", isOn: $includePDFPQPair)
            Toggle("Highlight m/w", isOn: $includePDFMWPair)
        }
    }

    private func generatePDF() async {
        do {
            statusMessage = "Generating PDF..."

            let document = DyslexicoDocument(
                documentAuthor: "DyslexicoKit Sample",
                title: "DyslexicoKit Sample",
                pages: [documentText]
            )

            let configuration = DyslexicoPdfConfiguration(
                pdfAuthor: "DyslexicoKit",
                style: selectedExportStyle.exportStyle,
                includeLetterHighlights: includeHighlights,
                pageSize: .a4
            )

            let result = try await DyslexicoPdfGenerator().exportToPdf(
                with: document,
                pdfConfiguration: configuration,
                typography: pdfTypography
            )

            pdfURL = result.url
            statusMessage = "PDF generated"
        } catch {
            statusMessage = error.localizedDescription
        }
    }

    private var pdfTypography: DyslexicoTypographySettings {
        DyslexicoTypographySettings(
            fontSettings: .init(
                family: selectedPDFFontFamily.fontFamily,
                size: pdfFontSize
            ),
            fontHighlightOptions: pdfHighlightOptions,
            colorSettings: .init(
                fontColor: pdfLetterColor.color,
                backgroundColor: pdfBackgroundColor.color
            ),
            spacingSettings: .init(
                lineSpacing: pdfLineSpacing,
                letterSpacing: pdfLetterSpacing
            )
        )
    }

    private var pdfHighlightOptions: Set<DyslexicoLetterHighlightOption> {
        var options: Set<DyslexicoLetterHighlightOption> = []

        if includePDFBDPair {
            options.insert(.bdPair)
        }

        if includePDFPQPair {
            options.insert(.pqPair)
        }

        if includePDFMWPair {
            options.insert(.mwPair)
        }

        return options
    }

    private func seedPDFTypography(from typography: DyslexicoTypographySettings) {
        selectedPDFFontFamily = demoFontFamily(from: typography.fontSettings.family)
        pdfFontSize = typography.fontSettings.size
        pdfLineSpacing = typography.spacingSettings.lineSpacing
        pdfLetterSpacing = typography.spacingSettings.letterSpacing
        includePDFBDPair = typography.fontHighlightOptions.contains(.bdPair)
        includePDFPQPair = typography.fontHighlightOptions.contains(.pqPair)
        includePDFMWPair = typography.fontHighlightOptions.contains(.mwPair)
        pdfLetterColor = demoLetterColor(from: typography.colorSettings.fontColor)
        pdfBackgroundColor = demoBackgroundColor(from: typography.colorSettings.backgroundColor)
    }

    private func demoFontFamily(from fontFamily: DyslexicoFontFamily) -> DemoFontFamily {
        switch fontFamily {
        case .atkinsonHyperlegible:
            return .atkinsonHyperlegible
        case .lexend:
            return .lexend
        case .openDyslexic, .systemDefault, .custom:
            return .openDyslexic
        }
    }

    private func demoLetterColor(from letterColor: LetterColor) -> DemoLetterColor {
        switch letterColor {
        case .black:
            return .black
        case .brown:
            return .brown
        case .navy:
            return .navy
        case .charcoal:
            return .charcoal
        case .error, .custom:
            return .error
        }
    }

    private func demoBackgroundColor(from backgroundColor: BackgroundColor) -> DemoBackgroundColor {
        switch backgroundColor {
        case .cream:
            return .cream
        case .sepia:
            return .sepia
        case .pastel:
            return .pastel
        case .dark, .custom:
            return .dark
        }
    }
}

private enum SampleExportStyle: String, CaseIterable, Identifiable {
    case dyslexiaFriendly
    case standard

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dyslexiaFriendly:
            return "Dyslexia Friendly"
        case .standard:
            return "Standard"
        }
    }

    var exportStyle: DyslexicoExportStyle {
        switch self {
        case .dyslexiaFriendly:
            return .dyslexiaFriendly
        case .standard:
            return .standard
        }
    }
}

#Preview {
    NavigationStack {
        PDFScreen()
    }
}
