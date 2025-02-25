//
//  String+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/17/25.
//

public extension String {
    func configurePlural(count: Int) -> String {
        return "\(self)\(count == 1 ? "" : "s")"
    }
}
