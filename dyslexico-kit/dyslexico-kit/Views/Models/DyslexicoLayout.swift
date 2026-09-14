//
//  DyslexicoLayout.swift
//  dyslexico-kit
//
//  Created by Milan Parađina on 14.09.2026..
//

import Foundation

public enum DyslexicoTextLayout {
case wrap(lines: Int?)
case singleLine
case scaleToFit(lines: Int, minimumScale: CGFloat)
}
