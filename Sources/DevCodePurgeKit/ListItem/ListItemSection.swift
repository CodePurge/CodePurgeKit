//
//  ListItemSection.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/25.
//

/// A protocol representing a section of list items.
/// Each section can contain multiple items and provides metadata about the section's state.
public protocol ListItemSection: Identifiable, Hashable {
    associatedtype Item: PurgableItem
    
    var id: String { get }
    var name: String { get }
    var items: [Item] { get }
    var itemCount: Int { get }
    var totalSize: Int64 { get }
    var selectedItemCount: Int { get }
    var selectionStatus: ListItemSectionSelectionStatus { get }
}


// MARK: - Default Values
public extension ListItemSection {
    /// Default implementation for the section's identifier, which is the name of the section.
    var id: String {
        return name
    }

    /// Default implementation for the total number of items in the section.
    var itemCount: Int {
        return items.count
    }

    /// Default implementation for the total size of all items in the section.
    var totalSize: Int64 {
        return items.map { $0.size }.calculateTotalSize()
    }

    /// Default implementation for the selection status of the section.
    /// - Returns:
    ///   - `.empty`: If no items are selected.
    ///   - `.all`: If all items are selected.
    ///   - `.some`: If some items are selected.
    var selectionStatus: ListItemSectionSelectionStatus {
        if selectedItemCount == 0 {
            return .empty
        } else if selectedItemCount == items.count {
            return .all
        } else {
            return .some
        }
    }
}
