//
//  PurgeRecord.swift
//
//
//  Created by Nikolai Nobadi on 1/22/25.
//

import Foundation

/// A record representing the details of a purge operation.
public struct PurgeRecord: Codable {
    public var date: Date
    public var itemInfo: ResultInfo
    public var simulatorInfo: ResultInfo
    
    /// The total size of all purged items and simulators.
    /// Returns `nil` if either the item size or simulator size is zero.
    public var totalSize: Int64? {
        guard itemInfo.size > 0, simulatorInfo.size > 0 else {
            return nil
        }
        
        return itemInfo.size + simulatorInfo.size
    }
    
    /// Initializes a new instance of `PurgeRecord`.
    /// - Parameters:
    ///   - date: The date of the purge operation.
    ///   - itemInfo: Information about the purged items.
    ///   - simulatorInfo: Information about the purged simulators.
    public init(date: Date, itemInfo: ResultInfo, simulatorInfo: ResultInfo) {
        self.date = date
        self.itemInfo = itemInfo
        self.simulatorInfo = simulatorInfo
    }
}


// MARK: - Dependencies
/// Information about the results of a purge operation.
public struct ResultInfo: Codable {
    public var size: Int64
    public var count: Int
    
    /// Initializes a new instance of `ResultInfo`.
    /// - Parameters:
    ///   - size: The total size of the purged items or simulators, in bytes.
    ///   - count: The total count of the purged items or simulators.
    public init(size: Int64, count: Int) {
        self.size = size
        self.count = count
    }
}
