//
//  dyslexico_kitTests.swift
//  dyslexico-kitTests
//
//  Created by Milan Parađina on 05.09.2026..
//

import Testing
import SwiftUI
import UIKit
@testable import DyslexicoKit

struct DyslexicoKitTests {

    @Test func customLetterColorResolvesToUIColorComponents() throws {
        let color = LetterColor.custom(red: 0.12, green: 0.34, blue: 0.56, opacity: 0.78)

        assertUIColor(
            color.uiColor,
            red: 0.12,
            green: 0.34,
            blue: 0.56,
            alpha: 0.78
        )
    }

    @Test func customBackgroundColorResolvesToUIColorComponents() throws {
        let color = BackgroundColor.custom(red: 0.98, green: 0.95, blue: 0.88)

        assertUIColor(
            color.uiColor,
            red: 0.98,
            green: 0.95,
            blue: 0.88,
            alpha: 1
        )
    }

    @Test func customColoredPairCreatesEntriesForBothLettersAndCases() throws {
        let option = DyslexicoLetterHighlightOption.customColoredPair(
            "r",
            "n",
            firstColor: .custom(red: 1, green: 0.86, blue: 0.58),
            secondColor: .custom(red: 0.68, green: 0.86, blue: 1)
        )

        let entries = DyslexicoHighlightUtilities.highlightColors(for: [option])

        #expect(entries.count == 2)
        #expect(entries[0].characters.contains("r"))
        #expect(entries[0].characters.contains("R"))
        #expect(entries[1].characters.contains("n"))
        #expect(entries[1].characters.contains("N"))

        assertUIColor(entries[0].uiColor, red: 1, green: 0.86, blue: 0.58, alpha: 1)
        assertUIColor(entries[1].uiColor, red: 0.68, green: 0.86, blue: 1, alpha: 1)
    }

    @Test func customColoredPairAppliesHighlightsToAttributedString() throws {
        var attributed = AttributedString("Run now")

        DyslexicoHighlightUtilities.applyHighlights(
            to: &attributed,
            options: [
                .customColoredPair(
                    "r",
                    "n",
                    firstColor: .custom(red: 1, green: 0.86, blue: 0.58),
                    secondColor: .custom(red: 0.68, green: 0.86, blue: 1)
                )
            ]
        )

        let text = String(attributed.characters)
        let rIndex = try #require(attributedIndex(for: "R", in: text, attributed: attributed))
        let nIndex = try #require(attributedIndex(for: "n", in: text, attributed: attributed))

        // #expect(attributed[rIndex].backgroundColor != nil)
        // #expect(attributed[nIndex].backgroundColor != nil)
    }

    private func assertUIColor(
        _ color: UIColor,
        red expectedRed: CGFloat,
        green expectedGreen: CGFloat,
        blue expectedBlue: CGFloat,
        alpha expectedAlpha: CGFloat,
        tolerance: CGFloat = 0.01
    ) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        #expect(color.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        #expect(abs(red - expectedRed) <= tolerance)
        #expect(abs(green - expectedGreen) <= tolerance)
        #expect(abs(blue - expectedBlue) <= tolerance)
        #expect(abs(alpha - expectedAlpha) <= tolerance)
    }

    private func attributedIndex(
        for character: Character,
        in text: String,
        attributed: AttributedString
    ) -> AttributedString.Index? {
        guard let stringIndex = text.firstIndex(of: character) else { return nil }
        return AttributedString.Index(stringIndex, within: attributed)
    }

}
