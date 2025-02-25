//
//  ProgressInfoDatasource.swift
//
//
//  Created by Nikolai Nobadi on 1/22/25.
//

import Foundation

/// A data source class for managing and updating progress information.
/// Conforms to `ObservableObject` for use in SwiftUI views.
public final class ProgressInfoDatasource: ObservableObject {
    @Published public var progressInfo: ProgressInfo?
    
    public init() { }
}


// MARK: - Delegate
extension ProgressInfoDatasource: ProgressInfoDelegate {
    /// Updates the current progress information.
    /// - Parameter info: The new progress information to update.
    public func updateProgress(_ info: ProgressInfo) {
        DispatchQueue.main.async { [weak self] in
            self?.progressInfo = info
        }
    }
}
