//
//  LinearGradient+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/17/25.
//

import SwiftUI

public extension LinearGradient {
    static let softGreenGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 129 / 255, green: 199 / 255, blue: 132 / 255),
            Color(red: 76 / 255, green: 175 / 255, blue: 80 / 255),
            Color(red: 56 / 255, green: 142 / 255, blue: 60 / 255)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let softYellowGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 255 / 255, green: 241 / 255, blue: 118 / 255),
            Color(red: 255 / 255, green: 213 / 255, blue: 79 / 255),
            Color(red: 255 / 255, green: 193 / 255, blue: 7 / 255)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let softRedGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 229 / 255, green: 115 / 255, blue: 115 / 255),
            Color(red: 211 / 255, green: 47 / 255, blue: 47 / 255),
            Color(red: 183 / 255, green: 28 / 255, blue: 28 / 255)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static func makeGradient(isLive: Bool) -> LinearGradient {
        return isLive ? .softGreenGradient : .softYellowGradient
    }
}
