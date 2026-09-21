//
//  DyslexicoButton.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import SwiftUI

/// Visual styles available for `DyslexicoButton`.
public enum DyslexicoButtonVariant {
    /// A filled primary action button.
    case primary

    /// A lighter secondary action button with a border.
    case secondary

    /// A destructive action button for dangerous operations.
    case destructive
}

/// A full-width SwiftUI button styled with DyslexicoKit typography and colors.
public struct DyslexicoButton: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.dyslexicoTypography) private var typography

    private let title: LocalizedStringResource
    private let systemImage: String?
    private let variant: DyslexicoButtonVariant
    private let textSettings: DyslexicoTextSettings
    private let action: () -> Void

    /// Creates a DyslexicoKit button.
    ///
    /// - Parameters:
    ///   - title: The localized button title.
    ///   - systemImage: An optional SF Symbol shown before the title.
    ///   - variant: The visual style used for the button.
    ///   - textSettings: Role and overrides used to resolve the button title typography.
    ///   - action: The action performed when the button is tapped.
    public init(
        _ title: LocalizedStringResource,
        systemImage: String? = nil,
        variant: DyslexicoButtonVariant = .primary,
        textSettings: DyslexicoTextSettings = .button,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.variant = variant
        self.textSettings = textSettings
        self.action = action
    }

    /// The rendered SwiftUI view.
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .accessibilityHidden(true)
                }

                Text(title)
                    .font(typography.font(for: textSettings))
                    .tracking(typography.spacingSettings.letterSpacing)
                    .lineSpacing(typography.spacingSettings.lineSpacing)
            }
            .frame(minHeight: 44)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: variant == .secondary ? 1 : 0)
            }
            .opacity(isEnabled ? 1 : 0.55)
        }
        .buttonStyle(.plain)
    }

    private var backgroundColor: Color {
        switch variant {
        case .primary:
            return DyslexicoColors.accentPrimary
        case .secondary:
            return DyslexicoColors.backgroundElevated
        case .destructive:
            return DyslexicoColors.semanticError
        }
    }

    private var foregroundColor: Color {
        switch variant {
        case .primary, .destructive:
            return .white
        case .secondary:
            return DyslexicoColors.blackTextColor
        }
    }

    private var borderColor: Color {
        variant == .secondary ? DyslexicoColors.borderStrong.opacity(0.45) : .clear
    }
}

private struct DyslexicoButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            DyslexicoButton("Continue", systemImage: "arrow.right") {}
            DyslexicoButton("Cancel", variant: .secondary) {}
            DyslexicoButton("Delete", variant: .destructive) {}
        }
        .padding()
    }
}

#Preview {
    DyslexicoButtonPreviews.previews
}
