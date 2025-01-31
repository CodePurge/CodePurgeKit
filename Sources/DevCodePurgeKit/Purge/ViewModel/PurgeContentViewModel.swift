//
//  PurgeViewModel.swift
//
//
//  Created by Nikolai Nobadi on 1/23/25.
//

import Foundation

/// The view model responsible for managing the state and actions of the purge process.
final class PurgeContentViewModel: ObservableObject {
    @Published var state: PurgeState
    
    private let info: ConfirmPurgeInfo
    private let delegate: PurgeRecordDelegate
    private let datasource: ProgressInfoDatasource
    private let onFinished: () -> Void
    
    /// Initializes the `PurgeContentViewModel`.
    /// - Parameters:
    ///   - delegate: The delegate responsible for handling purge operations.
    ///   - datasource: The datasource for tracking progress information. Defaults to a new instance.
    ///   - onFinished: A closure executed when the purge operation finishes (triggering the view to be dismissed).
    init(info: ConfirmPurgeInfo, delegate: PurgeRecordDelegate, datasource: ProgressInfoDatasource = .init(), onFinished: @escaping () -> Void) {
        self.info = info
        self.delegate = delegate
        self.state = .initial(info)
        self.datasource = datasource
        self.onFinished = onFinished
        
        datasource.$progressInfo
            .compactMap { $0 }
            .map { .inProgress($0) }
            .assign(to: &$state)
    }
}

// MARK: - Display Data
extension PurgeContentViewModel {
    var itemCount: Int {
        return info.itemCount
    }
    
    var totalSize: Int64 {
        return info.purgableMemory
    }
}


// MARK: - Actions
extension PurgeContentViewModel {
    func finishPurge() {
       onFinished()
    }
    
    func startPurge() {
        Task {
            do {
                if let record = try await delegate.startPurge(progressDelegate: datasource) {
                    await setRecord(record)
                }
            } catch {
                // TODO: - handle error
                print("purge failed", error)
                await setState(.finished(nil))
            }
        }
    }
}


// MARK: - MainActor
@MainActor
private extension PurgeContentViewModel {
    /// Updates the state to `.finished` with the provided purge record.
    /// - Parameter record: The record containing the results of the purge operation.
    func setRecord(_ record: PurgeRecord) {
        state = .finished(record)
    }
    
    func setState(_ newState: PurgeState) {
        state = newState
    }
}


// MARK: - Dependencies
/// A protocol that defines the requirements for a purge record delegate.
public protocol PurgeRecordDelegate {
    /// Starts the purge operation and returns the results.
    /// - Parameter progressDelegate: The delegate responsible for tracking progress.
    /// - Returns: A record of the purge operation, or `nil` if no record is available.
    /// - Throws: An error if the purge operation fails.
    func startPurge(progressDelegate: ProgressInfoDelegate?) async throws -> PurgeRecord?
}
