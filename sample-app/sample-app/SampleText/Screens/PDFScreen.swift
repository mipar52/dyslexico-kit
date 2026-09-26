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
    @State private var documentText = SampleText.longForm
    @State private var includeHighlights = true
    @State private var selectedExportStyle: SampleExportStyle = .dyslexiaFriendly
    @State private var pdfURL: URL?
    @State private var statusMessage = "Ready"

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
        .dyslexicoTypography(.defaultSettings)
        .dyslexicoReadableBackground()
        .navigationTitle("PDF")
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
                typography: .defaultSettings
            )

            pdfURL = result.url
            statusMessage = "PDF generated"
        } catch {
            statusMessage = error.localizedDescription
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
