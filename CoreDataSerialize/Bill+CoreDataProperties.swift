//
//  Bill+CoreDataProperties.swift
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

extension Bill {

    @NSManaged var billNumber: String?
    @NSManaged var restaurantName: String?
    @NSManaged var waiterName: String?
    @NSManaged var uuid: String?
    @NSManaged var party: NSManagedObject?
    @NSManaged var billItems: NSSet?

}
