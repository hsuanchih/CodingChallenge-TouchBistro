//
//  ViewController.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var context: NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The core data model has 5 entities that represent part of a restaurant.
        // Floor represents a physical floor or section in a restaurant.
        // A Floor can have many Tables. A Table may have a Party on it.
        // A Party represents a group of people dining in the restaurant.
        // A Party can have 0, 1, or many Bills. There are many Bills if they choose to do bill splitting.
        // A Bill has 1 or more BillItems. A BillItem is one line on a receipt. eg. '1x Burger $7.99'
        
        // Write a method that serializes a given NSManagedObject and its relationships into a dictionary of type
        // [String: [String: Any]]
        // This is a dictionary where the key is a String, and the value is another dictionary of keys/values
        // every entity has a uuid that can be used as the key
        
        // Example
        
        // Given the following Bill and BillItems:
        /*
        bill1.uuid = "QWERTY"
        bill1.restaurantName = "Sample Cafe"
        bill1.waiterName = "Jeeves"
        bill1.billNumber = "1"
        
        item1.uuid = "ASDFG"
        item1.name = "Eggs"
        item1.quantity = 2
        item1.unitPrice = 2.99
        item1.bill = bill1
        
        item2.uuid = "ZXCVB"
        item2.name = "Coffee"
        item2.quantity = 1
        item2.unitPrice = 1.99
        item2.bill = bill1
        */
        
        // serializing bill1 should return a dictionary like the following:
        /*
        
         {
            "QWERTY" =  {
                            "uuid" = "QWERTY"
                            "restaurantName" = "Sample Cafe"
                            "waiterName" = "Jeeves"
                            "billNumber" = "1"
                            "billItems" = ["ASDFG", "ZXCVB"] // keys are sorted alphabetically
                        },
 
            "ASDFG" =   {
                            "uuid" = "ASDFG"
                            "name" = "Eggs"
                            "quantity" = 2
                            "unitPrice" = 2.99
                            "bill" = "QWERTY"
                        },
         
            "ZXCVB" =   {
                            "uuid" = "ZXCVB"
                            "name" = "Coffee"
                            "quantity" = 1
                            "unitPrice" = 1.99
                            "bill" = "QWERTY"
                        },
         }
         
         */
        
        // Important Notes
        // As you can see, each value in the dictionary is another dictionary of keys/values that represent that NSManagedObject
        // However,the value for relationship keys are replaced with a String or array of Strings
        // If the relationship is a to-one, the value is the uuid of the relationship object
        // if the relationship is a to-many, the value is an array of uuids of the relationship objects
        // The final dictionary will have dictionary representations for every NSManagedObject linked to the original managed object
        // In this example, if Bill or BillItem has other relationships and they are not nil, they would be included in this dictionary
        
        // Helpful APIs
        // https://developer.apple.com/documentation/coredata/nsentitydescription
        // https://developer.apple.com/documentation/coredata/nsattributedescription
        // https://developer.apple.com/documentation/coredata/nsrelationshipdescription
        
        // This project is setup with a Sample Database. Fetch the first floor and print out its serialized dictionary
        let request = NSFetchRequest<Floor>(entityName: "Floor")
        let floor = try! context.fetch(request).first!
        
        let dictionary = floor.dictionaryRepresentation() // fill in implementation
        
        let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted, .sortedKeys])
        let string = String(data: jsonData, encoding: .utf8)!
        print(string)
        
        // see 'data.json' file for example json output.
    }
}

