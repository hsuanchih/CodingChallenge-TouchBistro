//
//  BillItem.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import Foundation
import CoreData

extension BillItem : UUIDEncodable {
    enum CodingKeys: String, CodingKey {
        case name, uuid, quantity, unitPrice, bill
    }
    func encode(to encoder: Encoder) throws {
        guard !isVisiting else { return }
        isVisiting.toggle()
        var container = encoder.uuidContainer(uuidEncodable: self, keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(quantity.decimalValue, forKey: .quantity)
        try container.encode(unitPrice.decimalValue, forKey: .unitPrice)
        try container.encodeUUIDEncodableIfPresent(bill, forKey: .bill, withEncoder: encoder)
        isVisiting.toggle()
    }
}

class BillItem: NSManagedObject, GraphCycleDetector {
    var isVisiting: Bool = false
}
