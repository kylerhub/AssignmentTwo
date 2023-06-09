//
//  Persistence.swift
//  AssignmentOne
//
//  Created by jennifer-wei lin on 18/4/2023.
//

import Foundation
import CoreData

///The purpose of this milestone to create an advanced Master/Detail app with persistent data using CoreData.
struct PH{
    static let shared = PH()
    let container : NSPersistentContainer
    init () {
        container = NSPersistentContainer(name: "MyModel")
        container.loadPersistentStores{ _, error in
            if let e = error {
                fatalError("loading error with \(e)")
            }
        }
    }
}
