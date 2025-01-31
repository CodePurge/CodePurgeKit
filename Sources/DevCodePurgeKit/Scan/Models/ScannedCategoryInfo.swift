//
//  ScannedCategoryInfo.swift
//
//
//  Created by Nikolai Nobadi on 1/4/25.
//

import Foundation

/// A protocol representing detailed information about a scanned category.
/// Combines metadata from the category and additional scan-specific data.
public protocol ScannedCategoryInfo: HeroAnimatable, DisplayableCategory {
    /// The type of the category associated with the scanned data.
    associatedtype Category: ScannableCategory

    /// The category this scanned data belongs to.
    var category: Category { get }

    /// The total size of all items in the category, in bytes.
    var size: Int64 { get }

    /// The total size of selected items in the category, in bytes.
    var selectedSize: Int64 { get }
}


// MARK: - Default Values
public extension ScannedCategoryInfo {
    /// The unique identifier for the scanned category, derived from the associated category.
    var id: String {
        return category.id
    }

    /// The name of the scanned category, derived from the associated category.
    var name: String {
        return category.name
    }

    /// A summary description of the scanned category, derived from the associated category.
    var summary: String {
        return category.summary
    }

    /// Detailed information about the scanned category, including tips and guidance, derived from the associated category.
    var detailInfo: PurgeCategoryDetailInfo {
        return category.detailInfo
    }
}
