//  ContentView.swift
//  AssignmentOne
//
//  Created by jennifer-wei lin on 14/3/2023.
//
import SwiftUI

///The ContentView struct is the Master View for the checklists that navigates to the items of each checklist
///Importantly, all data now need to be persistent through JSON serialisation.

struct ContentView: View {
    @Environment(\.managedObjectContext) var ctx
    @FetchRequest(entity: FavouritePlace.entity(), sortDescriptors: [NSSortDescriptor(key: "place", ascending: true)])
    var favouriteplaces:FetchedResults<FavouritePlace>
    @State var place = ""
    
    @State var myTitle = "Favourite Places"
    
    ///You display a Loading indicator, while your data are being loaded.
    @State var isLoading = true
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    VStack {
                        TextField("place name", text: $place)
                        List {
                            
                            ForEach(favouriteplaces){
                                favouriteplace in
                                NavigationLink(favouriteplace.place ?? ""){
                                    ListDetailView(favouriteplace: favouriteplace)
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
    
    func addNewPlace(){
        if place == "" {return}
        let favouriteplace = FavouritePlace(context: ctx)
        favouriteplace.place = place
        saveData()
    }
    
    func deletePlace(_ idx: IndexSet){
        idx.map{favouriteplaces[$0]}.forEach {place in
            ctx.delete(place)
        }
        saveData()
    }

    
}

