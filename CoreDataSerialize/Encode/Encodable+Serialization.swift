//
//  Encodable+Serialization.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/8.
//

import Foundation

enum SerilizationError : Error {
    case typeConversion
}

extension Encodable {
    func dictionaryRepresentation() throws -> [String: [String: Any]] {
        guard let result = try JSONSerialization.jsonObject(
            with: try JSONEncoder().encode(self),
            options: .allowFragments
            ) as? [String: [String: Any]] else {
            throw SerilizationError.typeConversion
        }
        return result
    }
}
