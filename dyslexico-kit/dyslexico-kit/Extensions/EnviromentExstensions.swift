//
//  EnviromentExstensions.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 12.09.2026..
//

import SwiftUI

private struct DyslexicoTypographyKey: EnvironmentKey {
    static let defaultValue: DyslexicoTypographySettings = .defaultSettings
}

/// Environment values used by DyslexicoKit.
public extension EnvironmentValues {
    /// The typography configuration available to DyslexicoKit views and modifiers in the SwiftUI environment.
    var dyslexicoTypography: DyslexicoTypographySettings {
        get { self[DyslexicoTypographyKey.self] }
        set { self[DyslexicoTypographyKey.self] = newValue }
    }
}

/// Environment modifiers for configuring DyslexicoKit across a SwiftUI hierarchy.
public extension View {
    /// Injects DyslexicoKit typography settings into a SwiftUI view hierarchy.
    ///
    /// Apply this near the root of a screen to make `DyslexicoText`, inputs, buttons, labels, and
    /// `.dyslexicoText(...)` modifiers use the same reading preferences.
    func dyslexicoTypography(_ settings: DyslexicoTypographySettings) -> some View {
        environment(\.dyslexicoTypography, settings)
    }
}
