//
//  Array+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

/// Extension to calculate the total size of an array of integers.
public extension Array where Element == Int64 {
    /// Sums up all elements in the array.
    /// - Returns: The total sum of the array's elements.
    func calculateTotalSize() -> Int64 {
        reduce(0, +)
    }
}
