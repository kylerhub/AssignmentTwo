//
//  AssignmentOneTests.swift
//  AssignmentOneTests
//
//  Created by jennifer-wei lin on 14/3/2023.
//
import XCTest
import CoreData
@testable import AssignmentTwo

final class AssignmentOneTests: XCTestCase {
    
    func testLatStr(){
        let model = MyLocation.shared
        model.latStr = "45"
        XCTAssert(model.latStr == "45.00000")
        model.latStr = "91"
        XCTAssert(model.latStr == "45.00000")
        model.latStr = "-45.123456"
        XCTAssert(model.latStr == "-45.12346")
    }
    
    func testLongStr(){
        let model = MyLocation.shared
        model.longStr = "45"
        XCTAssert(model.longStr == "45.00000")
        model.longStr = "181"
        XCTAssert(model.longStr == "45.00000")
        model.longStr = "-45.123456"
        XCTAssert(model.longStr == "-45.12346")
    }
    
    // Test for FavouritePlace extension

    func testGetImage() async {
        let place = FavouritePlace(context: PH.shared.container.viewContext)
        place.strUrl = "https://example.com/image.jpg"
        
        let image = await place.getImage()
        
        XCTAssertNotNil(image)
    }
    
    func testSaveData() throws {
        let myLocation = MyLocation()
        myLocation.name = "San Francisco"
        
        XCTAssertNoThrow(try saveData())
    }
    
    func testUpdateFromRegion() {
        var location = MyLocation()
        location.region.center.latitude = 45.678
        location.region.center.longitude = -90.123
        
        location.updateFromRegion()
        
        XCTAssertEqual(location.latitude, 45.678)
        XCTAssertEqual(location.longitude, -90.123)
    }
    
    func testSetupRegion() {
        var location = MyLocation()
        location.latitude = 40.123
        location.longitude = -80.456
        
        location.setupRegion()
        
        XCTAssertEqual(location.region.center.latitude, 40.123)
        XCTAssertEqual(location.region.center.longitude, -80.456)
    }
    
    func testFromAddressToLoc() async {
        var location = MyLocation()
        location.name = "1600 Amphitheatre Parkway, Mountain View, CA"
        
        try? await location.fromAddressToLoc()
        
        XCTAssertEqual(location.latitude, 37.4220, accuracy: 0.001)
        XCTAssertEqual(location.longitude, -122.0841, accuracy: 0.001)
    }
}


