//
//  LivePurgeResultInfo.swift
//  
//
//  Created by Nikolai Nobadi on 1/23/25.
//

/// Represents the result of a live purge operation, including the purge record and a list of failed IDs.
public struct LivePurgeResultInfo {
    /// The record containing details about the completed purge operation.
    public let record: PurgeRecord
    
    /// A list of IDs that represent items that failed to be purged.
    public let failureIdList: [String]
    
    /// Initializes a new instance of `LivePurgeResultInfo`.
    /// - Parameters:
    ///   - record: The purge record with details of the operation.
    ///   - failureIdList: A list of IDs corresponding to the items that could not be purged.
    public init(record: PurgeRecord, failureIdList: [String]) {
        self.record = record
        self.failureIdList = failureIdList
    }
}
