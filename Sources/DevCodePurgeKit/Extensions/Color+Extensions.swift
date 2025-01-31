//
//  Color+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/15/25.
//

import SwiftUI

public extension Color {
    static let softRed = Color(red: 229 / 255, green: 115 / 255, blue: 115 / 255)
    static let softGreen = Color(red: 129 / 255, green: 199 / 255, blue: 132 / 255)
    static let softYellow = Color(red: 255 / 255, green: 213 / 255, blue: 79 / 255)
    static let softBlue = Color(red: 100 / 255, green: 181 / 255, blue: 246 / 255)
    static let softGray = Color(red: 176 / 255, green: 190 / 255, blue: 197 / 255)
    static let darkSoftGray = Color(red: 55 / 255, green: 71 / 255, blue: 79 / 255)
    
    static func purgeTint(isLive: Bool) -> Color {
        return isLive ? .softGreen : .softYellow
    }
}
