//
//  CheckBoxRowViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import SwiftUI

struct CheckBoxRowViewModifier: ViewModifier {
    @Environment(\.purgeIsLive) private var isLive
    
    let isSelected: Bool
    let isDisabled: Bool
    let trailingPadding: CGFloat
    let toggle: () -> Void
    
    func body(content: Content) -> some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            if !isDisabled {
                Image(systemName: isSelected ? "checkmark.rectangle.fill" : "rectangle")
                    .font(.title)
                    .foregroundStyle(Color.purgeTint(isLive: isLive))
                    .onTapGesture {
                        toggle()
                    }
                    .padding(.trailing, trailingPadding)
            }
            
            content
        }
    }
}

public extension View {
    /// Adds a checkbox for selection functionality to a row view.
    ///
    /// This modifier uses `CheckBoxRowViewModifier`, which depends on the `purgeIsLive` environment key
    /// to determine the color of the checkbox, adapting its appearance based on whether the app is in live mode.
    ///
    /// - Parameters:
    ///   - isSelected: A Boolean indicating whether the row is selected.
    ///   - isDisabled: A Boolean indicating whether the checkbox is disabled. Default is `false`.
    ///   - trailingPadding: The padding to apply after the checkbox. Default is `16`.
    ///   - toggle: The action to execute when toggling the checkbox.
    func withCheckboxSelection(isSelected: Bool, isDisabled: Bool = false, trailingPadding: CGFloat = 16, toggle: @escaping () -> Void) -> some View {
        modifier(CheckBoxRowViewModifier(isSelected: isSelected, isDisabled: isDisabled, trailingPadding: trailingPadding, toggle: toggle))
    }
}
