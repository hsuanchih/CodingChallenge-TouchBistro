//
//  AppDelegate.swift
//  CoreDataSerialize
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        print(applicationDocumentsDirectory)
        importSampleDatabase()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "TouchBistro.CoreDataSerialize" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("CoreDataSerialize", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SampleDatabase.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}

private extension AppDelegate {
    
    func importSampleDatabase() {
        let docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! + "/"
        let fileManager = NSFileManager.defaultManager()
        let files = try! fileManager.contentsOfDirectoryAtPath(docDir)
        
        // delete old data
        for file in files {
            if fileManager.isDeletableFileAtPath(docDir + file) {
                _ = try? NSFileManager.defaultManager().removeItemAtPath(docDir + file)
            }
        }
        
        // move sample db to documents folder
        let bundleDBPath = NSBundle.mainBundle().pathForResource("SampleDatabase", ofType: "sqlite")
        let newPath = docDir + "SampleDatabase" + ".sqlite"
        _ = try? NSFileManager.defaultManager().copyItemAtPath(bundleDBPath!, toPath: newPath)
    }
    
    func seedSampleDatabase() {
        let context = managedObjectContext
        
        let floor = NSEntityDescription.insertNewObjectForEntityForName("Floor", inManagedObjectContext: context) as! Floor
        floor.uuid = NSUUID().UUIDString
        floor.name = "First Floor"
        
        let table1 = NSEntityDescription.insertNewObjectForEntityForName("Table", inManagedObjectContext: context) as! Table
        table1.uuid = NSUUID().UUIDString
        table1.name = "101"
        table1.numberOfSeats = 4
        table1.floor = floor
        
        let table2 = NSEntityDescription.insertNewObjectForEntityForName("Table", inManagedObjectContext: context) as! Table
        table2.uuid = NSUUID().UUIDString
        table2.name = "102"
        table2.numberOfSeats = 2
        table2.floor = floor
        
        let party1 = NSEntityDescription.insertNewObjectForEntityForName("Party", inManagedObjectContext: context) as! Party
        party1.uuid = NSUUID().UUIDString
        party1.orderNumber = "98"
        party1.name = "Derek"
        party1.table = table1
        
        let party2 = NSEntityDescription.insertNewObjectForEntityForName("Party", inManagedObjectContext: context) as! Party
        party2.uuid = NSUUID().UUIDString
        party2.orderNumber = "99"
        party2.name = "Tayson"
        party2.table = table2
        
        let bill1 = NSEntityDescription.insertNewObjectForEntityForName("Bill", inManagedObjectContext: context) as! Bill
        bill1.uuid = NSUUID().UUIDString
        bill1.restaurantName = "Sample Cafe"
        bill1.waiterName = "Jeeves"
        bill1.billNumber = "1"
        bill1.party = party1
        
        let bill2 = NSEntityDescription.insertNewObjectForEntityForName("Bill", inManagedObjectContext: context) as! Bill
        bill2.uuid = NSUUID().UUIDString
        bill2.restaurantName = "Sample Cafe"
        bill2.waiterName = "Jeeves"
        bill2.billNumber = "2"
        bill2.party = party2
        
        let bill3 = NSEntityDescription.insertNewObjectForEntityForName("Bill", inManagedObjectContext: context) as! Bill
        bill3.uuid = NSUUID().UUIDString
        bill3.restaurantName = "Sample Cafe"
        bill3.waiterName = "Jeeves"
        bill3.billNumber = "3"
        bill3.party = party2
        
        let item1 = NSEntityDescription.insertNewObjectForEntityForName("BillItem", inManagedObjectContext: context) as! BillItem
        item1.uuid = NSUUID().UUIDString
        item1.name = "Eggs"
        item1.quantity = NSDecimalNumber(double: 2)
        item1.unitPrice = NSDecimalNumber(double: 2.99)
        item1.bill = bill1
        
        let item2 = NSEntityDescription.insertNewObjectForEntityForName("BillItem", inManagedObjectContext: context) as! BillItem
        item2.uuid = NSUUID().UUIDString
        item2.name = "Coffee"
        item2.quantity = NSDecimalNumber(double: 1)
        item2.unitPrice = NSDecimalNumber(double: 1.99)
        item2.bill = bill1
        
        let item3 = NSEntityDescription.insertNewObjectForEntityForName("BillItem", inManagedObjectContext: context) as! BillItem
        item3.uuid = NSUUID().UUIDString
        item3.name = "Burger"
        item3.quantity = NSDecimalNumber(double: 1)
        item3.unitPrice = NSDecimalNumber(double: 7.99)
        item3.bill = bill2
        
        let item4 = NSEntityDescription.insertNewObjectForEntityForName("BillItem", inManagedObjectContext: context) as! BillItem
        item4.uuid = NSUUID().UUIDString
        item4.name = "Fries"
        item4.quantity = NSDecimalNumber(double: 1)
        item4.unitPrice = NSDecimalNumber(double: 3.99)
        item4.bill = bill2
        
        let item5 = NSEntityDescription.insertNewObjectForEntityForName("BillItem", inManagedObjectContext: context) as! BillItem
        item5.uuid = NSUUID().UUIDString
        item5.name = "Pasta"
        item5.quantity = NSDecimalNumber(double: 1)
        item5.unitPrice = NSDecimalNumber(double: 12.99)
        item5.bill = bill3
        
        try! context.save()
    }
}

