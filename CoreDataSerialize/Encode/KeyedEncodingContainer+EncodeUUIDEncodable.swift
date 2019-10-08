//
//  KeyedEncodingContainer+EncodeUUIDEncodable.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/8.
//

import Foundation

public extension KeyedEncodingContainer {
    
    mutating func encodeUUIDEncodableIfPresent<T>(_ value: T?, forKey key: KeyedEncodingContainer<K>.Key, withEncoder encoder: Encoder) throws where T : UUIDEncodable {
        try value?.encode(to: encoder)
        try encodeIfPresent(value?.uuid, forKey: key)
    }
    mutating func encodeUUIDEncodablesIfPresent<T:Collection>(_ values: T?, forKey key: KeyedEncodingContainer<K>.Key, withEncoder encoder: Encoder) throws where  T.Element : UUIDEncodable {
        try encodeIfPresent(
            (values?.sorted { $0.uuid < $1.uuid })?.map { (value) -> String in
                try value.encode(to: encoder)
                return value.uuid
            },
            forKey: key
        )
    }
}
