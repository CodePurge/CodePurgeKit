//
//  XCTestCase+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import XCTest
import CodePurgeKit

extension XCTestCase {
    func makeItem(id: String = "0", name: String = "folder", dateModified: Date? = nil, size: Int64 = 100) -> MockItem {
        return .init(id: id, name: name, dateModified: dateModified, size: size)
    }
}
