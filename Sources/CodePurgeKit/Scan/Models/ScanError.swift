//
//  ScanError.swift
//
//
//  Created by Nikolai Nobadi on 3/10/25.
//

public enum ScanError: Error {
    case emptyPath
    case missingFolder
    case other(String)
}
