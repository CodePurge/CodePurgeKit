//
//  PurgableItem.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import Foundation

/// A protocol defining the properties of an item that can be purged.
/// Conforming types represent entities that can be managed and removed from storage.
public protocol PurgableItem: Identifiable, Hashable {
    /// A unique identifier for the item.
    var id: String { get }

    /// The name of the item.
    var name: String { get }

    /// The date the item was last modified. This value is optional.
    var dateModified: Date? { get }

    /// The size of the item, represented in bytes.
    var size: Int64 { get }

    /// The file URL of the item, if available.
    var url: URL? { get }

    /// The type of the item, categorizing it for purge operations.
    var type: PurgableItemType { get }
}

// TODO: - this may not be the most elegant solution to determine the type of item being purged
public enum PurgableItemType: Codable {
    case archives, derivedData, documentation, deviceSupport, coreSimulators, previewSimulators, swiftPackages, otherCaches
    
    public var name: String {
        switch self {
        case .archives:
            return "Archives"
        case .derivedData:
            return "Derived Data"
        case .documentation:
            return "Xcode Documentation"
        case .deviceSupport:
            return "iOS Device Support"
        case .coreSimulators:
            return "Core Simulators"
        case .previewSimulators:
            return "SwiftUI Preview Simulators"
        case .swiftPackages:
            return "Swift Packages"
        case .otherCaches:
            return "Other Caches"
        }
    }
}
