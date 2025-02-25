//
//  PurgeDelegate.swift
//
//
//  Created by Nikolai Nobadi on 1/15/25.
//

import Foundation

/// A protocol defining a delegate responsible for performing purge operations.
public protocol PurgeDelegate {
    func purgeItems(_ items: [any PurgableItem], progressDelegate: ProgressInfoDelegate?) async throws -> PurgeResult
}

// MARK: - Dependencies
/// An enumeration representing the result of a purge operation.
public enum PurgeResult {
    case practiceResult
    case liveResult(LivePurgeResultInfo)
}
