//
//  AssignmentOneApp.swift
//  AssignmentOne
//
//  Created by jennifer-wei lin on 16/3/2023.
//

import SwiftUI

@main

///Struct for the app
struct AssignmentOneApp: App {
    
    //uses testChecklists data
    
    @State var model:DataModel = DataModel()
    
    var ph = PH.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, ph.container.viewContext)
        }
    }
}

