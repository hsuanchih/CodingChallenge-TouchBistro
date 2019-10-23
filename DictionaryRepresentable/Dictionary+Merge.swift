//
//  Dictionary+Merge.swift
//  CoreDataSerialize
//
//  Created by Hsuan-Chih Chuang on 2019/10/22.
//

import Foundation

extension Dictionary {
    func merging(_ dict: [Key: Value]) -> Self {
        return merging(dict) { (lhs, _) in lhs }
    }
    mutating func merge(_ dict: [Key: Value]) {
        self.merge(dict) { (lhs, _) in lhs }
    }
}
