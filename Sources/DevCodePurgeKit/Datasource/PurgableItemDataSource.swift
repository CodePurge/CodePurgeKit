// PurgableItemDataSource.swift
// Created by Nikolai Nobadi on 1/3/25.

import Foundation

/// A data source that manages purgable items and their selection states.
/// Publishes changes to total size, selected size, and selected items.
public final class PurgableItemDataSource<Item: PurgableItem>: ObservableObject {
    /// The list of all items.
    @Published public var list: [Item]
    /// The total size of all items in the list.
    @Published public var totalSize: Int64 = 0
    /// The total size of selected items.
    @Published public var selectedSize: Int64 = 0
    /// The set of selected items.
    @Published public var selectedItems: Set<Item>

    /// Initializes the data source with optional initial values.
    /// - Parameters:
    ///   - list: The initial list of items. Default is an empty list.
    ///   - selectedItems: The initial set of selected items. Default is an empty set.
    public init(list: [Item] = [], selectedItems: Set<Item> = []) {
        self.list = list
        self.selectedItems = selectedItems

        $list
            .map { list in
                return list.map({ $0.size }).calculateTotalSize()
            }
            .assign(to: &$totalSize)

        $selectedItems
            .map { list in
                return list.map({ $0.size }).calculateTotalSize()
            }
            .assign(to: &$selectedSize)
    }
}


// MARK: - Helpers
public extension PurgableItemDataSource {
    /// Converts the `selectedItems` set to an array for easy iteration.
    var selectedItemArray: [Item] {
        return .init(selectedItems)
    }
}


// MARK: - Actions
public extension PurgableItemDataSource {
    /// Checks if an item is selected.
    /// - Parameter item: The item to check.
    /// - Returns: `true` if the item is selected, `false` otherwise.
    func isSelected(_ item: Item) -> Bool {
        return selectedItems.contains(item)
    }

    /// Selects an item if it is not already selected.
    /// - Parameter item: The item to select.
    func selectItem(_ item: Item) {
        if !isSelected(item) {
            selectedItems.insert(item)
        }
    }

    /// Unselects an item if it is currently selected.
    /// - Parameter item: The item to unselect.
    func unselectItem(_ item: Item) {
        if isSelected(item) {
            selectedItems.remove(item)
        }
    }

    /// Toggles the selection state of an item.
    /// - Parameter item: The item to toggle.
    func toggleItem(_ item: Item) {
        if isSelected(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }

    /// Toggles the selection state for a group of items.
    /// - Parameter items: The list of items to toggle.
    func toggleAllItems(_ items: [Item]) {
        let selectedItems = items.filter({ isSelected($0) })

        if selectedItems.isEmpty {
            for item in items {
                selectItem(item)
            }
        } else {
            for item in items {
                unselectItem(item)
            }
        }
    }

    /// Removes an item from both the list and selected items.
    /// - Parameter itemId: The identifier of the item to remove.
    func removeSingleItemFromAllLists(itemId: String) {
        if let index = list.firstIndex(where: { $0.id == itemId }) {
            list.remove(at: index)
        }

        if let index = selectedItems.firstIndex(where: { $0.id == itemId }) {
            selectedItems.remove(at: index)
        }
    }
    
    /// Retrieves the IDs of all selected items, excluding specific IDs.
    /// - Parameter excludingIds: The list of IDs to exclude.
    /// - Returns: An array of selected item IDs excluding the specified IDs.
    func getSelectedItemIds(excludingIds: [String]) -> [String] {
        return selectedItems.map({ $0.id }).filter({ !excludingIds.contains($0) })
    }
    
    /// Removes multiple items from both the list and selected items based on their IDs.
    /// - Parameter idList: The list of item IDs to remove.
    func removeItemsFromAllLists(idList: [String]) {
        for id in idList {
            removeSingleItemFromAllLists(itemId: id)
        }
    }
    
    /// Resets the data source by removing all items from the list and selected items.
    func resetDatasource() {
        removeItemsFromAllLists(idList: list.map({ $0.id }))
    }
}
