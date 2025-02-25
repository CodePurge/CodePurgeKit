//
//  ListItem.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/25.
//

/// A protocol representing a hierarchical list item.
/// Each item can optionally have child items and provides data for rendering in a list.
public protocol ListItem: Identifiable {
    /// The type of item this list item represents.
    associatedtype Item: PurgableItem

    /// The type of section this item belongs to.
    associatedtype ItemSection: ListItemSection where ItemSection.Item == Item

    /// A unique identifier for the item.
    var id: String { get }

    /// The data for rendering this item in a list row.
    var rowData: ListRowItemData<Item, ItemSection> { get }

    /// The child items of this list item, if any.
    var children: [Self]? { get }
}

// MARK: - Dependencies
/// An enumeration representing the data for rendering a list row.
/// - `row`: A single list item.
/// - `section`: A section containing multiple list items.
public enum ListRowItemData<Item: PurgableItem, Section: ListItemSection> where Section.Item == Item {
    case row(Item)
    case section(Section)
}
