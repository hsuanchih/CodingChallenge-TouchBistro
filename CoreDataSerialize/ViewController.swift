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
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

