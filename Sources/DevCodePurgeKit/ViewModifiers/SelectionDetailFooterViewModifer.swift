//
//  SelectionDetailFooterViewModifer.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import SwiftUI

struct SelectionDetailFooterViewModifer: ViewModifier {
    @Environment(\.purgeIsLive) private var isLive
    
    let selectionCount: Int
    let selectionSize: Int64
    let hideCount: Bool
    let isShowing: Bool
    let padding: CGFloat
    
    private var didSelectItems: Bool {
        return selectionCount > 0
    }
    
    func body(content: Content) -> some View {
        VStack {
            content
            
            if isShowing {
                HStack {
                    if !hideCount {
                        Text("\(selectionCount) items selected")
                            .padding(.horizontal)
                    }
                    
                    Text("Selected Memory to Purge:")
                    PurgeText(selectionSize)
                        .font(didSelectItems ? .title : .headline)
                        .foregroundStyle(didSelectItems ? Color.purgeTint(isLive: isLive) : Color.primary)
                }
                .font(.headline)
                .padding(.vertical, padding)
            }
        }
    }
}

public extension View {
    /// Adds a footer view displaying details about selected items.
    ///
    /// This modifier uses `SelectionDetailFooterViewModifier`, which depends on the `purgeIsLive` environment key
    /// to adjust the appearance of the footer, such as the text color and styling, based on whether the app is in live mode.
    ///
    /// - Parameters:
    ///   - selectionCount: The number of selected items.
    ///   - selectionSize: The total size of selected items.
    ///   - hideCount: A Boolean indicating whether to hide the count of selected items. Default is `false`.
    ///   - isShowing: A Boolean indicating whether the footer is visible. Default is `true`.
    ///   - padding: The vertical padding around the footer content. Default is `10`.
    func withSelectionDetailFooter(selectionCount: Int, selectionSize: Int64, hideCount: Bool = false, isShowing: Bool = true, padding: CGFloat = 10) -> some View {
        modifier(SelectionDetailFooterViewModifer(selectionCount: selectionCount, selectionSize: selectionSize, hideCount: hideCount, isShowing: isShowing, padding: padding))
    }
}
