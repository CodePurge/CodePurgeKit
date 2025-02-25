//
//  Int64+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import Foundation

/// Extension for formatting `Int64` values as storage sizes.
public extension Int64 {
    /// Converts the value into a human-readable storage size string.
    /// - Example: `1024` becomes `1 KB`.
    var toStorageSize: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useAll]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: self)
    }
    
    /// 18.3 MB, which seems to be default size for empty simulators
    static var baseSimulatorSize: Int64 {
        return 18260000
    }
}
