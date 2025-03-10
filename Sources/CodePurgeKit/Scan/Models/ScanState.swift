//
//  ScanState.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/25.
//

/// An enumeration representing the various states of a scanning process.
public enum ScanState: Equatable {
    case notStarted
    case inProgress(ScanDetails)
    case finished
}

public struct ScanDetails: Equatable {
    public let category: String
    public let progress: ProgressInfo
    
    public init(category: String, progress: ProgressInfo) {
        self.category = category
        self.progress = progress
    }
}
