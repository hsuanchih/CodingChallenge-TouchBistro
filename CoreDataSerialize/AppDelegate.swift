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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(NSPersistentContainer.defaultDirectoryURL().path)
        importSampleDatabase()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CoreDataSerialize")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

private extension AppDelegate {
    
    func importSampleDatabase() {
        let fileManager = FileManager.default
        
        let defaultDir = NSPersistentContainer.defaultDirectoryURL().path + "/"
        let files = try! fileManager.contentsOfDirectory(atPath: defaultDir)
        
        // delete old data
        for file in files {
            if fileManager.isDeletableFile(atPath: defaultDir + file) {
                try? fileManager.removeItem(atPath: defaultDir + file)
            }
        }
        
        // move sample db to default dir
        let bundleDBPath = Bundle.main.path(forResource: "SampleDatabase", ofType: "sqlite")!
        let newPath = defaultDir + "CoreDataSerialize" + ".sqlite"
        try? fileManager.copyItem(atPath: bundleDBPath, toPath: newPath)
    }
    
    func seedSampleDatabase() {
        let context = persistentContainer.viewContext
        
        let floor = Floor(context: context)
        floor.uuid = NSUUID().uuidString
        floor.name = "First Floor"
        
        let table1 = Table(context: context)
        table1.uuid = NSUUID().uuidString
        table1.name = "101"
        table1.numberOfSeats = 4
        table1.floor = floor
        
        let table2 = Table(context: context)
        table2.uuid = NSUUID().uuidString
        table2.name = "102"
        table2.numberOfSeats = 2
        table2.floor = floor
        
        let party1 = Party(context: context)
        party1.uuid = NSUUID().uuidString
        party1.orderNumber = "98"
        party1.name = "Derek"
        party1.table = table1
        
        let party2 = Party(context: context)
        party2.uuid = NSUUID().uuidString
        party2.orderNumber = "99"
        party2.name = "Tayson"
        party2.table = table2
        
        let bill1 = Bill(context: context)
        bill1.uuid = NSUUID().uuidString
        bill1.restaurantName = "Sample Cafe"
        bill1.waiterName = "Jeeves"
        bill1.billNumber = "1"
        bill1.party = party1
        
        let bill2 = Bill(context: context)
        bill2.uuid = NSUUID().uuidString
        bill2.restaurantName = "Sample Cafe"
        bill2.waiterName = "Jeeves"
        bill2.billNumber = "2"
        bill2.party = party2
        
        let bill3 = Bill(context: context)
        bill3.uuid = NSUUID().uuidString
        bill3.restaurantName = "Sample Cafe"
        bill3.waiterName = "Jeeves"
        bill3.billNumber = "3"
        bill3.party = party2
        
        let item1 = BillItem(context: context)
        item1.uuid = NSUUID().uuidString
        item1.name = "Eggs"
        item1.quantity = NSDecimalNumber(value: 2.0)
        item1.unitPrice = NSDecimalNumber(value: 2.99)
        item1.bill = bill1
        
        let item2 = BillItem(context: context)
        item2.uuid = NSUUID().uuidString
        item2.name = "Coffee"
        item2.quantity = NSDecimalNumber(value: 1.0)
        item2.unitPrice = NSDecimalNumber(value: 1.99)
        item2.bill = bill1
        
        let item3 = BillItem(context: context)
        item3.uuid = NSUUID().uuidString
        item3.name = "Burger"
        item3.quantity = NSDecimalNumber(value: 1.0)
        item3.unitPrice = NSDecimalNumber(value: 7.99)
        item3.bill = bill2
        
        let item4 = BillItem(context: context)
        item4.uuid = NSUUID().uuidString
        item4.name = "Fries"
        item4.quantity = NSDecimalNumber(value: 1.0)
        item4.unitPrice = NSDecimalNumber(value: 3.99)
        item4.bill = bill2
        
        let item5 = BillItem(context: context)
        item5.uuid = NSUUID().uuidString
        item5.name = "Pasta"
        item5.quantity = NSDecimalNumber(value: 1.0)
        item5.unitPrice = NSDecimalNumber(value: 12.99)
        item5.bill = bill3
        
        try! context.save()
    }
}

