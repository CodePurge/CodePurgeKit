//
//  InfoButtonViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/18/25.
//

import SwiftUI

struct InfoButtonViewModifier: ViewModifier {
    @State private var isHovered: Bool = false
    
    let categoryName: String
    let alignment: Alignment
    let openWindow: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                Button {
                    print("Opening \(categoryName) details")
                    openWindow()
                } label: {
                    Image(systemName: isHovered ? "questionmark.diamond.fill" : "questionmark.diamond")
                        .font(.title)
                        .foregroundStyle(Color.softBlue)
                }
                .buttonStyle(.plain)
                .padding()
                .onHover { hovering in
                    isHovered = hovering
                }
            }
    }
}

extension View {
    /// Adds an information button to a view for displaying additional details.
    ///
    /// This modifier uses `InfoButtonModifier`, which displays a button with a question mark icon. The button's
    /// appearance changes when hovered over, and it executes a provided action to open a window with more details.
    ///
    /// - Parameters:
    ///   - categoryName: The name of the category associated with the details.
    ///   - openWindow: The action to execute when the button is pressed to display more information.
    func withShowDetailsInfoButton(categoryName: String, alignment: Alignment, openWindow: @escaping () -> Void) -> some View {
        self.modifier(InfoButtonViewModifier(categoryName: categoryName, alignment: alignment, openWindow: openWindow))
    }
}
