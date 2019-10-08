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
        precondition(self is Encodable)
        do { return try (self as! Encodable).dictionaryRepresentation() } catch { print(error) }
        return [:]
    }
}
