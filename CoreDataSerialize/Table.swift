//
//  Table.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import Foundation
import CoreData

extension Table : UUIDEncodable {
    enum CodingKeys: String, CodingKey {
        case numberOfSeats, uuid, name, party, floor
    }
    func encode(to encoder: Encoder) throws {
        guard !isVisiting else { return }
        isVisiting.toggle()
        var container = encoder.uuidContainer(uuidEncodable: self, keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(numberOfSeats, forKey: .numberOfSeats)
        try container.encodeUUIDEncodableIfPresent(party, forKey: .party, withEncoder: encoder)
        try container.encodeUUIDEncodableIfPresent(floor, forKey: .floor, withEncoder: encoder)
        isVisiting.toggle()
    }
}

class Table: NSManagedObject, GraphCycleDetector {
    var isVisiting: Bool = false
}
