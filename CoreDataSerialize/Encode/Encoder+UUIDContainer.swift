//
//  Encoder+UUIDContainer.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/8.
//

import Foundation

extension Encoder {
    func uuidContainer<Key: CodingKey>(uuidEncodable: UUIDEncodable, keyedBy: Key.Type) -> KeyedEncodingContainer<Key> {
        var mainContainer = container(keyedBy: UUIDAsKey.self)
        return mainContainer.nestedContainer(keyedBy: keyedBy, forKey: UUIDAsKey(stringValue: uuidEncodable.uuid)!)
    }
}
