//
//  MockItem.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import Foundation
import CodePurgeKit

struct MockItem: PurgableItem {
    let id: String
    let name: String
    let dateModified: Date?
    let size: Int64
    var url: URL?
    
    var type: PurgableItemType {
        return .archives
    }
}
