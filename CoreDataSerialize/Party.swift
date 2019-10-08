//
//  Party.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import Foundation
import CoreData

extension Party : UUIDEncodable {
    enum CodingKeys: String, CodingKey {
        case name, orderNumber, uuid, bills, table
    }
    func encode(to encoder: Encoder) throws {
        guard !isVisiting else { return }
        isVisiting.toggle()
        var container = encoder.uuidContainer(uuidEncodable: self, keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(orderNumber, forKey: .orderNumber)
        try container.encodeUUIDEncodablesIfPresent(bills, forKey: .bills, withEncoder: encoder)
        try container.encodeUUIDEncodableIfPresent(table, forKey: .table, withEncoder: encoder)
        isVisiting.toggle()
    }
}

class Party: NSManagedObject, GraphCycleDetector {
    var isVisiting: Bool = false
}
