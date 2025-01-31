//
//  PurgeText.swift
//  
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import SwiftUI

/// A view that displays a formatted storage size as text.
///
/// The displayed size is formatted using the `toStorageSize` property of `Int64`.
public struct PurgeText: View {
    /// The storage size to display, in bytes.
    let size: Int64

    /// Initializes the view with the specified size.
    /// - Parameter size: The storage size to display.
    public init(_ size: Int64) {
        self.size = size
    }

    public var body: some View {
        Text(size.toStorageSize)
    }
}
