//
//  PurgeIsLive.swift
//
//
//  Created by Nikolai Nobadi on 1/15/25.
//

import SwiftUI

/// A custom environment key to determine whether the app is in live mode.
public struct PurgeIsLive: EnvironmentKey {
    /// The default value for the environment key, indicating live mode is off.
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    /// A Boolean value indicating whether the app is in live mode.
    var purgeIsLive: Bool {
        get { self[PurgeIsLive.self] }
        set { self[PurgeIsLive.self] = newValue }
    }
}
