//
//  AssignmentOneApp.swift
//  AssignmentOne
//
//  Created by jennifer-wei lin on 16/3/2023.
//

import SwiftUI

@main

///Struct for the app that uses coredata persistence 
struct AssignmentTwoApp: App {
    
    @StateObject var model = MyLocation.shared
    
    var ph = PH.shared
    var body: some Scene {
        WindowGroup {
            ContentView(model:model).environment(\.managedObjectContext, ph.container.viewContext)
        }
    }
}

