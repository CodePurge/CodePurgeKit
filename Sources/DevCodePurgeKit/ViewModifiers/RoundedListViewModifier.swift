//
//  RoundedListViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/15/25.
//

import SwiftUI

struct RoundedListViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: 10))
    }
}

public extension View {
    /// Applies a rounded rectangle shape to the view, giving it a clean, modern appearance.
    ///
    /// This modifier uses `RoundedListViewModifier` to clip the view into a rectangle with rounded corners.
    func roundedList() -> some View {
        modifier(RoundedListViewModifier())
    }
}
