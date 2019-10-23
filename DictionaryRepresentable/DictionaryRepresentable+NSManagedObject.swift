//
//  DictionaryRepresentable+NSManagedObject.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/22.
//

import Foundation
import CoreData

extension DictionaryRespresentable where Self : NSManagedObject {
    
    func dictionaryRepresentation(visited: inout Set<String>) -> Result {
        guard !visited.contains(uuid) else { return Result() }
        visited.insert(uuid)
        var keyValues : [String: Any] = [:], dictionaryRespresentables = Result()
        entity.attributesByName.forEach { (attribute) in
            switch attribute.value.attributeValueClassName {
            case NSStringFromClass(NSString.self), NSStringFromClass(NSNumber.self), NSStringFromClass(NSDecimalNumber.self):
                encode(value: value(forKey: attribute.key), for: attribute.key, to: &keyValues)
            default:
                break
            }
        }
        entity.relationshipsByName.forEach { relationship in
            let value = self.value(forKey: relationship.key)
            if let toOne = value as? DictionaryRespresentable {
                dictionaryRespresentables.merge(encode(value: toOne, for: relationship.key, to: &keyValues, visited: &visited))
            } else if let values = value as? Set<NSManagedObject>, let toMany = Array(values) as? Array<DictionaryRespresentable> {
                dictionaryRespresentables.merge(encode(values: toMany, for: relationship.key, to: &keyValues, visited: &visited))
            }
        }
        return [uuid : keyValues].merging(dictionaryRespresentables)
    }
}

extension Table     : DictionaryRespresentable {}
extension BillItem  : DictionaryRespresentable {}
extension Floor     : DictionaryRespresentable {}
extension Bill      : DictionaryRespresentable {}
extension Party     : DictionaryRespresentable {}
