//
//  CoreDataSerializeTests.swift
//  CoreDataSerializeTests
//
//  Created by Tayson Nguyen on 2016-09-12.
//
//

import XCTest
import CoreData
@testable import CoreDataSerialize

class CoreDataSerializeTests: XCTestCase {
    
    func sampleJSONString() -> String {
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let string = String(data: data, encoding: .utf8)!
        return string
    }
    
    func testExample() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<Floor>(entityName: "Floor")
        let floor = try! context.fetch(request).first!
        let dictionary = floor.dictionaryRepresentation() // fill in implementation
        let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted, .sortedKeys])
        let string = String(data: jsonData, encoding: .utf8)!
        XCTAssertTrue(string == sampleJSONString())
    }
}
