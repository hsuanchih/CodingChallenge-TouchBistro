//
//  UUIDEncodable.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/8.
//

import Foundation

public protocol UUIDEncodable : Encodable {
    var uuid : String { get }
}

struct UUIDAsKey : CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int?
    init?(intValue: Int) { return nil }
}
