//
//  Bill.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import Foundation
import CoreData

extension Bill : UUIDEncodable {
    enum CodingKeys: String, CodingKey {
        case billNumber, restaurantName, waiterName, uuid, billItems, party
    }
    func encode(to encoder: Encoder) throws {
        guard !isVisiting else { return }
        isVisiting.toggle()
        var container = encoder.uuidContainer(uuidEncodable: self, keyedBy: CodingKeys.self)
        try container.encode(billNumber, forKey: .billNumber)
        try container.encode(restaurantName, forKey: .restaurantName)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(waiterName, forKey: .waiterName)
        try container.encodeUUIDEncodableIfPresent(party, forKey: .party, withEncoder: encoder)
        try container.encodeUUIDEncodablesIfPresent(billItems, forKey: .billItems, withEncoder: encoder)
        isVisiting.toggle()
    }
}

class Bill: NSManagedObject, GraphCycleDetector {
    var isVisiting: Bool = false
}
