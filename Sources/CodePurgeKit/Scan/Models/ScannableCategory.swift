//
//  ScannableCategory.swift
//
//
//  Created by Nikolai Nobadi on 1/4/25.
//

/// A protocol representing a category of items that can be scanned.
/// Each category provides metadata and detailed information.
public protocol ScannableCategory: DisplayableCategory {
    /// A unique identifier for the category.
    var id: String { get }

    /// The name of the category.
    var name: String { get }

    /// A summary description of the category.
    var summary: String { get }

    /// Detailed information about the category, including tips and guidance.
    var detailInfo: PurgeCategoryDetailInfo { get }
}


// MARK: - Default Values
public extension ScannableCategory {
    /// Default implementation for the category's unique identifier, which uses the category's name.
    var id: String {
        return name
    }
}
