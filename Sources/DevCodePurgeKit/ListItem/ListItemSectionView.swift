//
//  ListItemSectionView.swift
//  
//
//  Created by Nikolai Nobadi on 1/18/25.
//

import SwiftUI

/// A view representing a section in a list, including a checkbox for selection and metadata about the section.
public struct ListItemSectionView<Section: ListItemSection>: View {
    let section: Section
    let toggleAll: () -> Void
    
    /// Initializes the view with a section and a toggle action.
    /// - Parameters:
    ///   - section: The section to display.
    ///   - toggleAll: The action to execute when toggling the selection state of the section.
    public init(section: Section, toggleAll: @escaping () -> Void) {
        self.section = section
        self.toggleAll = toggleAll
    }
    
    public var body: some View {
        HStack {
            ListItemSectionCheckbox(status: section.selectionStatus, toggle: toggleAll)
            
            Text(section.name)
                .bold()
                .font(.title)
                .padding(.horizontal)
            
            Text("\(section.items.count) archives")
                .font(.caption)
                .padding(.horizontal, 30)
                .foregroundStyle(.secondary)
        }
        .withTrailingSizeLabel(prefix: "Total Size", size: section.totalSize)
    }
}
