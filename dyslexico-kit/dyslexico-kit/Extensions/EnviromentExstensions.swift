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

public extension EnvironmentValues {
    var dyslexicoTypography: DyslexicoTypographySettings {
        get { self[DyslexicoTypographyKey.self] }
        set { self[DyslexicoTypographyKey.self] = newValue }
    }
}

public extension View {
    func dyslexicoTypography(_ settings: DyslexicoTypographySettings) -> some View {
        environment(\.dyslexicoTypography, settings)
    }
}
