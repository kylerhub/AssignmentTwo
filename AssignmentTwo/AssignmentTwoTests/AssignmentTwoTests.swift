//
//  AssignmentOneTests.swift
//  AssignmentOneTests
//
//  Created by jennifer-wei lin on 14/3/2023.
//
import XCTest
@testable import AssignmentOne

final class AssignmentOneTests: XCTestCase {

    //.Function for testing the items struct
    func testItems() throws {
        let item1 = Items(item: "Milk", checkedStatus: "unchecked", newCheckedStatus: "")
        let item2 = Items(item: "Cheese", checkedStatus: "checked", newCheckedStatus: "")
        
        XCTAssert(item1.item == "Milk")
        XCTAssert(item1.checkedStatus == "unchecked")
        
        XCTAssert(item2.item == "Cheese")
        XCTAssert(item2.checkedStatus == "checked")
    }
    
    /// Function for testing Checklist struct

    func testChecklist() throws {
           let checklist = Checklist()
           XCTAssertEqual(checklist.checklist, "New checklist")
           XCTAssertEqual(checklist.items.count, 0)
       }
    
    /// Function for testing getFile() function for JSON persistence
    
    func testGetFile() throws {
            let url = getFile()
            XCTAssertNotNil(url)
            XCTAssertTrue(url!.absoluteString.contains("mychecklists.json"))
        }
    ///Function for testing DataModel struct
    func testDataModel() {
        var dataModel = DataModel()
        
        func testLoad() {
            
            // Load the checklists from the file into a new DataModel instance
            
            dataModel.load()
            
            // Check that the loaded checklists match the original checklists
            XCTAssertEqual(dataModel.checklists.count, 1)
        }
            /// Test saving data
        dataModel.save()
        let fileURL = getFile()
        XCTAssertNotNil(fileURL)
        guard let data = try? Data(contentsOf: fileURL!) else {
            XCTFail("Unable to load data from file")
            return
        }
        let decodedDataModel = try? JSONDecoder().decode(DataModel.self, from: data)
        XCTAssertNotNil(decodedDataModel)
    }
    
}
