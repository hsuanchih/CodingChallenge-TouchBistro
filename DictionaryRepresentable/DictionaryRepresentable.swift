//
//  DictionaryRepresentable.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/22.
//

import Foundation

protocol DictionaryRespresentable : UUIDEncodable {
    typealias Result = [String: [String : Any]]
    func dictionaryRepresentation() -> [String: [String : Any]]
    func dictionaryRepresentation(visited: inout Set<String>) -> [String: [String : Any]]
}

extension DictionaryRespresentable {
    
    func dictionaryRepresentation() -> Result {
        var visited : Set<String> = []
        return dictionaryRepresentation(visited: &visited)
    }
    
    func encode(value: Any?, for key: String, to store: inout [String: Any]) {
        guard let value = value else { return }
        store[key] = value
    }
    
    func encode(value: DictionaryRespresentable, for key: String, to store: inout [String: Any], visited: inout Set<String>) -> Result {
        encode(value: value.uuid, for: key, to: &store)
        return value.dictionaryRepresentation(visited: &visited)
    }
    
    func encode<T:Collection>(values: T, for key: String, to store: inout [String: Any], visited: inout Set<String>) -> Result where T.Element == DictionaryRespresentable {
        var dictionaryRespresentables = Result()
        encode(
            value: values.sorted { $0.uuid < $1.uuid }.map({ (value) -> String in
                dictionaryRespresentables.merge(value.dictionaryRepresentation(visited: &visited))
                return value.uuid
            }),
            for: key,
            to: &store
        )
        return dictionaryRespresentables
    }
}
