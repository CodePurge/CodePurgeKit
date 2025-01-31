//
//  ListItemSectionSelectionStatus.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//


/// Enum representing the selection status of a list section.
public enum ListItemSectionSelectionStatus {
    case empty, some, all
}


// MARK: - Helpers
public extension ListItemSectionSelectionStatus {
    /// Provides the corresponding checkmark image name for the selection status.
    var checkmarkImageName: String {
        switch self {
        case .empty: 
            return "rectangle"
        case .some: 
            return "minus.rectangle.fill"
        case .all: 
            return "checkmark.rectangle.fill"
        }
    }
}
