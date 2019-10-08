//
//  Floor.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import Foundation
import CoreData

extension Floor : UUIDEncodable {
    enum CodingKeys: String, CodingKey {
        case uuid, name, tables
    }
    func encode(to encoder: Encoder) throws {
        guard !isVisiting else { return }
        isVisiting.toggle()
        var container = encoder.uuidContainer(uuidEncodable: self, keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encodeUUIDEncodablesIfPresent(tables, forKey: .tables, withEncoder: encoder)
        isVisiting.toggle()
    }
}

class Floor: NSManagedObject, GraphCycleDetector {
    var isVisiting: Bool = false
}
