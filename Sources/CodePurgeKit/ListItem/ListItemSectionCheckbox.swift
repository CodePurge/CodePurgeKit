//
//  ListItemSectionCheckbox.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import SwiftUI

/// A view representing a checkbox for a list section.
///
/// The checkbox reflects the current selection status of the section and allows toggling its state.
/// This view utilizes the `purgeIsLive` environment key to determine whether the app is in live mode,
/// which influences the appearance of the checkbox, such as its color.
public struct ListItemSectionCheckbox: View {
    @Environment(\.purgeIsLive) private var isLive
    
    let status: ListItemSectionSelectionStatus
    let toggle: () -> Void
    
    /// Initializes the checkbox with a selection status and toggle action.
    /// - Parameters:
    ///   - status: The current selection status of the section.
    ///   - toggle: The action to execute when the checkbox is toggled.
    public init(status: ListItemSectionSelectionStatus, toggle: @escaping () -> Void) {
        self.status = status
        self.toggle = toggle
    }
    
    public var body: some View {
        Image(systemName: status.checkmarkImageName)
            .padding()
            .font(.headline)
            .foregroundStyle(status.getColor(isLive: isLive))
            .onTapGesture {
                toggle()
            }
    }
}


// MARK: - Extension Dependencies
fileprivate extension ListItemSectionSelectionStatus {
    func getColor(isLive: Bool) -> Color {
        switch self {
        case .empty:
            return .softGray
        case .some:
            return .softRed
        case .all:
            return Color.purgeTint(isLive: isLive)
        }
    }
}
