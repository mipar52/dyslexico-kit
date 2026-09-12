//
//  DyslexicoTextView.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 08.09.2026..
//

import SwiftUI

struct DyslexicoTextView: View {
    //@Query private var preferencesList: [UserTypographyPreferences]
    
    let text: LocalizedStringResource
    var role: TextRole
    var type: FontTypeOption?
    var foregroundStyle: Color?
    var layout: DyslexicoTextLayout = .wrap(lines: nil)
    var alignment: TextAlignment = .leading
    
    private var prefs: UserTypographyPreferences {
        preferencesList.first ?? UserTypographyPreferences()
    }
    
    var body: some View {
        Text(text)
            .font(role.font(for: prefs, type: type))
            .foregroundStyle(foregroundStyle ?? role.color(for: prefs))
            .tracking(prefs.increasedLetterSpacing ? 2 : 0)
            .kerning(prefs.increasedLetterSpacing ? 0.6 : 0)
            .multilineTextAlignment(alignment)
            .applyDyslexicoTextLayout(layout)
            .accessibilityLabel(text)
    }
    
    enum TextRole {
        case title, body, caption
        
        func font(for prefs: UserTypographyPreferences, type: FontTypeOption?) -> Font {
            switch self {
            case .title:
                return prefs.selectedFont.font(size: prefs.fontSize + 16, type: type ?? .bold)
            case .body:
                return prefs.selectedFont.font(size: prefs.fontSize, type: type ?? .regular)
            case .caption:
                return prefs.selectedFont.font(size: prefs.fontSize - 2, type: type ?? .light)
            }
        }
        
        func color(for prefs: UserTypographyPreferences) -> Color {
            prefs.selectedTextColor.color
        }
    }
}

enum DyslexicoTextLayout {
    case wrap(lines: Int?)
    case singleLine
    case scaleToFit(lines: Int, minimumScale: CGFloat)
}

private extension View {
    @ViewBuilder
    func applyDyslexicoTextLayout(_ layout: DyslexicoTextLayout) -> some View {
        switch layout {
        case .wrap(let lines):
            self
                .lineLimit(lines)
                .fixedSize(horizontal: false, vertical: true)

        case .singleLine:
            self
                .lineLimit(1)
                .truncationMode(.tail)

        case .scaleToFit(let lines, let minimumScale):
            self
                .lineLimit(lines)
                .minimumScaleFactor(minimumScale)
                .allowsTightening(true)
        }
    }
}

#Preview {
    DyslexicoTextView()
}
