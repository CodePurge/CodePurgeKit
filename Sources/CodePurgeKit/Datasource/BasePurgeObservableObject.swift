// BasePurgeObservableObject.swift
// Created by Nikolai Nobadi on 1/3/25.

import Foundation

/// An observable object that manages and publishes aggregate data related to purging items.
/// Tracks total size, selected size, and the count of selected items based on a data source.
open class BasePurgeObservableObject<Item: PurgableItem>: ObservableObject {
    /// The total size of all items in the list.
    @Published public var totalSize: Int64 = 0
    /// The total size of all selected items.
    @Published public var selectedSize: Int64 = 0
    /// The total count of selected items.
    @Published public var selectedItemCount: Int = 0

    /// The data source containing the items to be purged.
    private let datasource: PurgableItemDataSource<Item>

    /// Initializes the observable object with a given data source.
    /// - Parameter datasource: The source of items and selection state.
    public init(datasource: PurgableItemDataSource<Item>) {
        self.datasource = datasource

        // Bind data source publishers to observable properties.
        datasource.$totalSize.assign(to: &$totalSize)
        datasource.$selectedSize.assign(to: &$selectedSize)
        datasource.$selectedItems.map({ $0.count }).assign(to: &$selectedItemCount)
    }
}

// MARK: - Actions
public extension BasePurgeObservableObject {
    /// Checks if an item is selected.
    /// - Parameter item: The item to check.
    /// - Returns: `true` if the item is selected, `false` otherwise.
    func isSelected(_ item: Item) -> Bool {
        return datasource.isSelected(item)
    }

    /// Toggles the selection state of a specific item.
    /// - Parameter item: The item to toggle.
    func toggleItem(_ item: Item) {
        datasource.toggleItem(item)
    }

    /// Toggles the selection state for a list of items.
    /// - Parameter items: The list of items to toggle.
    func toggleAllItems(_ items: [Item]) {
        datasource.toggleAllItems(items)
    }
}
