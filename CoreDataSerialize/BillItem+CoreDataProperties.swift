//
//  BillItem+CoreDataProperties.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BillItem {

    @NSManaged var name: String
    @NSManaged var quantity: NSDecimalNumber
    @NSManaged var unitPrice: NSDecimalNumber
    @NSManaged var uuid: String
    @NSManaged var bill: Bill

}
