//
//  NSManagedObject+Serialize.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-13.
//
//

import Foundation
import CoreData

extension NSManagedObject {

    func dictionaryRepresentation() -> [String: [String: Any]] {
        return (self as? DictionaryRespresentable)?.dictionaryRepresentation() ?? [:]
    }
}
