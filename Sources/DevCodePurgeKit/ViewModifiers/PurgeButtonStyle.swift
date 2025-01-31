//
//  PurgeButtonStyle.swift
//
//
//  Created by Nikolai Nobadi on 1/17/25.
//

import SwiftUI

/// A custom button style that provides a bold, colorful design with scaling and shadow effects.
///
/// The appearance of the button is influenced by the provided gradient, shape, and disabled state.
public struct PurgeButtonStyle<Shape: InsettableShape>: ButtonStyle {
    let shape: Shape
    let disabled: Bool
    let font: Font?
    let padding: CGFloat
    let gradient: LinearGradient
    
    /// Initializes the custom button style.
    /// - Parameters:
    ///   - shape: The shape of the button.
    ///   - gradient: The gradient for the button's background.
    ///   - font: The font to use for the button's text. Default is `nil`.
    ///   - padding: The padding around the buttons's text. Default is `20`.
    ///   - disabled: A Boolean indicating whether the button is disabled.
    public init(shape: Shape, gradient: LinearGradient, font: Font? = nil, padding: CGFloat = 20, disabled: Bool) {
        self.shape = shape
        self.disabled = disabled
        self.gradient = gradient
        self.font = font
        self.padding = padding
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .padding(padding)
            .foregroundColor(.black)
            .font(font ?? (disabled ? .body : .title))
            .background(gradient)
            .clipShape(shape)
            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 4)
            .overlay(shape.stroke(.white.opacity(0.6), lineWidth: 2))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.05)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .opacity(disabled ? 0.5 : 1)
    }
}

public extension ButtonStyle where Self == PurgeButtonStyle<Circle> {
    /// Creates a circular purge button style with a gradient based on the `isLive` state.
    ///
    /// - Parameters:
    ///   - isLive: A Boolean indicating whether the app is in live mode.
    ///   - disabled: A Boolean indicating whether the button is disabled. Default is `false`.
    static func circlePurgeStyle(isLive: Bool, disabled: Bool = false) -> PurgeButtonStyle<Circle> {
        return PurgeButtonStyle(shape: .circle, gradient: .makeGradient(isLive: isLive), disabled: disabled)
    }
}

public extension ButtonStyle where Self == PurgeButtonStyle<RoundedRectangle> {
    /// Creates a rounded rectangle purge button style with a custom gradient and corner radius.
    ///
    /// - Parameters:
    ///   - gradient: The gradient for the button's background.
    ///   - cornerRadius: The corner radius of the button. Default is `10`.
    ///   - font: The font to use for the button's text. Default is `nil`.
    ///   - padding: The padding around the buttons's text. Default is `20`.
    ///   - disabled: A Boolean indicating whether the button is disabled. Default is `false`.
    static func rectPurgeStyle(gradient: LinearGradient, cornerRadius: CGFloat = 10, font: Font? = nil, padding: CGFloat = 20, disabled: Bool = false) -> PurgeButtonStyle<RoundedRectangle> {
        return PurgeButtonStyle(shape: .rect(cornerRadius: cornerRadius), gradient: gradient, font: font, padding: padding, disabled: disabled)
    }
    
    /// Creates a rounded rectangle purge button style with a gradient based on the `isLive` state.
    ///
    /// - Parameters:
    ///   - isLive: A Boolean indicating whether the app is in live mode.
    ///   - cornerRadius: The corner radius of the button. Default is `10`.
    ///   - disabled: A Boolean indicating whether the button is disabled. Default is `false`.
    static func rectPurgeStyle(isLive: Bool, cornerRadius: CGFloat = 10, disabled: Bool = false) -> PurgeButtonStyle<RoundedRectangle> {
        return .rectPurgeStyle(gradient: .makeGradient(isLive: isLive), cornerRadius: cornerRadius, disabled: disabled)
    }
}
