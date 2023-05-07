//  ContentView.swift
//  AssignmentOne
//
//  Created by jennifer-wei lin on 14/3/2023.
//
import SwiftUI

///The ContentView struct is the Master View for the checklists that navigates to the items of each checklist
///The purpose of this milestone to create an advanced Master/Detail app with persistent data using CoreData.

struct ContentView: View {
    @Environment(\.managedObjectContext) var ctx
    @FetchRequest(entity: FavouritePlace.entity(), sortDescriptors: [NSSortDescriptor(key: "place", ascending: true)])
    var favouritePlaces:FetchedResults<FavouritePlace>
    @State var place = ""
    
    @State var myTitle = "Favourite Places"
    
    ///You display a Loading indicator, while your data are being loaded.
    @State var isLoading = true
    
    @ObservedObject var model:MyLocation
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    VStack {
                        TextField("Place name", text: $place)
                        List {
                            
                            ///Each item needs to be embedded in a Navigation Link that allows the user to get to a Detail View by clicking (tapping) on the list item.
                            ForEach(favouritePlaces){
                                favouritePlace in
                                NavigationLink(destination: ListDetailView(favouritePlace: favouritePlace, model: model)){
                                    RowView(favouritePlace: favouritePlace)
                                }
                                
                                
                            }.onDelete {
                                idx in deletePlace(idx)
                            }
                             
                            
                        }
                    }
                }
            }
            .navigationTitle(myTitle)
            .navigationBarItems(
                leading:
                    HStack {
                        
                        Button(action: {
                            myTitle = "Favourite Places"
                        }) {
                        }
                        EditButton()
                    },
                
                ///Adding
                trailing: Button(action: {
                    
                    addNewPlace()
                    place = ""
                    
                }) {
                    Image(systemName: "plus")
                }
            )
            .onAppear {
                isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isLoading = false

                }
            }
        }
    }
    
    ///The Master View needs to be fully editable, i.e., you need to be able to add elements.
    func addNewPlace(){
        if place == "" {return}
        let favouritePlace = FavouritePlace(context: ctx)
        favouritePlace.place = place
        saveData()
    }
    
    ///The Master View needs to be fully editable, i.e., remove elements.
    func deletePlace(_ idx: IndexSet){
        idx.map{favouritePlaces[$0]}.forEach {place in
            ctx.delete(place)
        }
        saveData()
    }

    
}
