//
//  DictionaryRepresentable+Introspectable.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/22.
//

import Foundation

protocol Introspectable {
    var properties : [Mirror.Child] { get }
}
extension Introspectable {
    var properties : [Mirror.Child] { return Mirror(reflecting: self).children.compactMap { $0 } }
}

extension DictionaryRespresentable where Self : Introspectable {
    
    func dictionaryRepresentation(visited: inout Set<String>) -> Result {
        guard !visited.contains(uuid) else { return Result() }
        visited.insert(uuid)
        var keyValues : [String: Any] = [:], dictionaryRespresentables = Result()
        properties.forEach { (key, value) in
            guard let key = key else { return }
            if let value = value as? DictionaryRespresentable {
                dictionaryRespresentables.merge(encode(value: value, for: key, to: &keyValues, visited: &visited))
            } else if let value = value as? Set<AnyHashable>, let values = Array(value) as? Array<DictionaryRespresentable> {
                dictionaryRespresentables.merge(encode(values: values, for: key, to: &keyValues, visited: &visited))
            } else {
                encode(value: value, for: key, to: &keyValues)
            }
        }
        return [uuid : keyValues].merging(dictionaryRespresentables)
    }
}
