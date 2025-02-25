//
//  PurgeState.swift
//
//
//  Created by Nikolai Nobadi on 1/23/25.
//

/// Represents the state of a purge operation.
enum PurgeState {
    /// The initial state before the purge operation starts.
    case initial(ConfirmPurgeInfo)
    
    /// The state indicating the purge operation is in progress, along with progress information.
    /// - Parameter progress: The current progress of the purge operation.
    case inProgress(ProgressInfo)
    
    /// The state indicating the purge operation is finished, with an optional record of the results.
    /// - Parameter record: The details of the completed purge operation, or `nil` if no record is available.
    case finished(PurgeRecord?)
}
