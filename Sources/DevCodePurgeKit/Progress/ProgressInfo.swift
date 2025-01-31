//
//  ProgressInfo.swift
//
//
//  Created by Nikolai Nobadi on 1/22/25.
//

/// A structure representing the progress of an operation.
public struct ProgressInfo: Equatable {
    public let details: String
    public let currentProgress: Int
    public let totalProgress: Int
    
    /// Initializes a new `ProgressInfo` instance with the specified details, current progress, and total progress.
    /// - Parameters:
    ///   - details: A description of the operation.
    ///   - currentProgress: The current progress of the operation.
    ///   - totalProgress: The total amount of progress required.
    public init(details: String, currentProgress: Int, totalProgress: Int) {
        self.details = details
        self.currentProgress = currentProgress
        self.totalProgress = totalProgress
    }
}

public extension ProgressInfo {
    /// Calculates the progress percentage based on the current and total progress.
    /// - Returns: An integer representing the progress as a percentage.
    var progressPercent: Int {
        return .init((Double(currentProgress) / Double(totalProgress)) * 100)
    }
    
    var percentText: String {
        return "\(progressPercent)%"
    }
}
