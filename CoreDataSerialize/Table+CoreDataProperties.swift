//
//  Table+CoreDataProperties.swift
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

extension Table {

    @NSManaged var numberOfSeats: NSNumber?
    @NSManaged var uuid: String?
    @NSManaged var name: String?
    @NSManaged var floor: NSManagedObject?
    @NSManaged var party: NSManagedObject?

}
