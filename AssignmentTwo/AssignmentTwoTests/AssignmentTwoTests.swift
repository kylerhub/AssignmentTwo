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
    
    var ctx: NSManagedObjectContext!
    var view: ListDetailView!
    
    func testGetImage() async throws {
        let place = FavouritePlace(context: ctx)
        place.strUrl = "https://picsum.photos/200"
        let image = try await place.getImage()
        XCTAssertNotNil(image)
    }
    
    func testSaveData() {
        let place = FavouritePlace(context: ctx)
        place.place = "Test Place"
        place.strUrl = "https://example.com/image.png"
        saveData()
        let fetchRequest = NSFetchRequest<FavouritePlace>(entityName: "FavouritePlace")
        let places = try! ctx.fetch(fetchRequest)
        XCTAssertEqual(places.count, 1)
        XCTAssertEqual(places[0].place, "Test Place")
        XCTAssertEqual(places[0].strUrl, "https://example.com/image.png")
    }
    
    func testDeletePlace() {
        let contentView = ContentView()
        let initialCount = contentView.favouritePlaces.count
        
        // Delete the first place
        let placeToDelete = contentView.favouritePlaces.first
        let idxToDelete = IndexSet(integer: 0)
        contentView.deletePlace(idxToDelete)
        
        // Check that the number of places has decreased by 1
        XCTAssertEqual(contentView.favouritePlaces.count, initialCount - 1)
        
        // Check that the correct place was deleted
        XCTAssertFalse(contentView.favouritePlaces.contains(placeToDelete!))
    }
    
    func testAddNewPlace() {
        let contentView = ContentView()
        let initialCount = contentView.favouritePlaces.count
        
        // Add a new place
        contentView.place = "New Place"
        contentView.addNewPlace()
        
        // Check that the number of places has increased by 1
        XCTAssertEqual(contentView.favouritePlaces.count, initialCount + 1)
        
        // Check that the new place was added with the correct name
        let newPlace = contentView.favouritePlaces.last
        XCTAssertEqual(newPlace?.place, "New Place")
    }
    
    func testAddNewPlaceDetails() throws {
        view.name = "Test"
        view.url = "https://www.example.com/image.jpg"
        view.latitude = "37.7749"
        view.longitude = "-122.4194"
        view.notes = "Test notes"
        view.addNewPlaceDetails()
        XCTAssertNotNil(view.favouritePlace.place)
        XCTAssertEqual(view.favouritePlace.place, "Test")
        XCTAssertNotNil(view.favouritePlace.strUrl)
        XCTAssertEqual(view.favouritePlace.strUrl, "https://www.example.com/image.jpg")
        let detailsFetchRequest: NSFetchRequest<Detail> = Detail.fetchRequest()
        detailsFetchRequest.predicate = NSPredicate(format: "belongto == %@", view.favouritePlace)
        let details = try ctx.fetch(detailsFetchRequest)
        XCTAssertEqual(details.count, 1)
        XCTAssertEqual(details.first?.latitude, "37.7749")
        XCTAssertEqual(details.first?.longitude, "-122.4194")
        XCTAssertEqual(details.first?.notes, "Test notes")
    }
    
    func testFetchDetails() throws {
        view.name = "Test"
        view.url = "https://www.example.com/image.jpg"
        view.latitude = "37.7749"
        view.longitude = "-122.4194"
        view.notes = "Test notes"
        view.addNewPlaceDetails()
        view.fetchDetails()
        XCTAssertEqual(view.details?.count, 1)
        XCTAssertEqual(view.details?.first?.latitude, "37.7749")
        XCTAssertEqual(view.details?.first?.longitude, "-122.4194")
        XCTAssertEqual(view.details?.first?.notes, "Test notes")
    }

    func testDeleteDetails() throws {
        view.name = "Test"
        view.url = "https://www.example.com/image.jpg"
        view.latitude = "37.7749"
        view.longitude = "-122.4194"
        view.notes = "Test notes"
        view.addNewPlaceDetails()
        view.fetchDetails()
        XCTAssertEqual(view.details?.count, 1)
        view.deleteDetails(IndexSet(integer: 0))
        XCTAssertEqual(view.details?.count, 0)
        let detailsFetchRequest: NSFetchRequest<Detail> = Detail.fetchRequest()
        detailsFetchRequest.predicate = NSPredicate(format: "belongto == %@", view.favouritePlace)
        let details = try ctx.fetch(detailsFetchRequest)
        XCTAssertEqual(details.count, 0)
    }
    
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


