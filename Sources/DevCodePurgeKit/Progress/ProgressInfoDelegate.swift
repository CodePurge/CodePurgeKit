//
//  ProgressInfoDelegate.swift
//
//
//  Created by Nikolai Nobadi on 1/22/25.
//

/// A protocol for updating progress information.
/// Classes conforming to this protocol should implement a method to handle progress updates.
public protocol ProgressInfoDelegate {
    /// Updates the progress with the provided information.
    /// - Parameter info: An instance of `ProgressInfo` containing the details, current progress, and total progress.
    func updateProgress(_ info: ProgressInfo)
}

