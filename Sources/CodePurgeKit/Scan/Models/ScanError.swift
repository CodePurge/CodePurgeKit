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

extension ScanError {
    var message: String {
        switch self {
        case .emptyPath:
            return "Looks like there was a problem with the path to this category. Reset permissions from Settings and try again if you keep getting this error."
        case .missingFolder:
            return "You don't have anything to clean for this category!"
        case .other(let message):
            return "Something went wrong. Please reset permissions from settings and try again. Error: \(message)"
        }
    }
}
