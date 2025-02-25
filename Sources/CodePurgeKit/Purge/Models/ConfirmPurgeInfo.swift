//
//  ConfirmPurgeInfo.swift
//
//
//  Created by Nikolai Nobadi on 1/28/25.
//

/// A structure containing information for confirming a purge operation.
/// This includes details such as the number of items, total memory to be purged, and UI text elements.
public struct ConfirmPurgeInfo {
    
    /// The title displayed in the confirmation prompt.
    public let title: String
    
    /// The type of items being purged (e.g., "folders", "simulators").
    public let itemType: String
    
    /// The total number of items selected for purging.
    public let itemCount: Int
    
    /// The total memory size of the items to be purged, in bytes.
    public let purgableMemory: Int64
    
    /// Additional details or warnings about the purge operation.
    public let details: [String]
    
    /// The text displayed on the confirmation button.
    public let buttonText: String
    
    /// Initializes a new `ConfirmPurgeInfo` instance.
    /// - Parameters:
    ///   - title: The title displayed in the confirmation prompt.
    ///   - itemType: The type of items being purged.
    ///   - itemCount: The total number of items selected for purging.
    ///   - purgableMemory: The total memory size of the items to be purged.
    ///   - details: Additional details or warnings about the purge operation.
    ///   - buttonText: The text displayed on the confirmation button.
    public init(title: String, itemType: String, itemCount: Int, purgableMemory: Int64, details: [String], buttonText: String) {
        self.title = title
        self.itemType = itemType
        self.itemCount = itemCount
        self.purgableMemory = purgableMemory
        self.details = details
        self.buttonText = buttonText
    }
}
