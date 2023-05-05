//
//  ListDetailView.swift
//  AssignmentOne
//
//  Created by jennifer-wei lin on 17/3/2023.
//

import SwiftUI
import CoreData
import MapKit

///The ListDetailView struct is the Detail View for the items within each checklist

struct ListDetailView: View {
    
    @Environment(\.managedObjectContext) var ctx
    var favouritePlace: FavouritePlace
    
    ///image (or its URL when in editing mode), the name, the location, and notes
    @State var details: [Detail]?
    @State var name = ""
    @State var url = ""
    @State var latitude = "0.0"
    @State var longitude = "0.0"
    
    @State var notes = ""
    
    @State var image = defaultImage
    
    @State var loading = false /// State variable to indicate loading status
    
    @ObservedObject var model:MyLocation
    @State var zoom = 10.0
    
    var body: some View {
        Group {
            if loading { /// Show ProgressView if loading is true
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else { /// Show List if loading is false
                VStack{
                    //The Detail View should show at least the image (or its URL when in editing mode), the name, the location, and notes.
                    TextField("New Place:", text: $name)
                    TextField("Enter Image URL:", text: $url)
                    TextField("Notes:", text: $notes)
                    
                    Text("Latitude/Longitude")
                    TextField("", text: $latitude)
                    TextField("", text: $longitude)
                    Image(systemName: "sparkle.magnifyingglass").onTapGesture{
                        checkLocation()
                    }
                    
                    Slider(value:$zoom, in: 10...60){
                        if !$0 {
                            checkZoom()
                        }
                    }
                    
                    ZStack{
                        Map(coordinateRegion: $model.region)
                        VStack{
                            Text("Latitude :\(model.region.center.latitude)")
                            Text("Longitude :\(model.region.center.longitude)")
                            Button("Update"){
                                checkMap()
                            }
                        }
                    }

                }
                Button("Add or Edit Place Details"){
                    addNewPlaceDetails()
                    fetchDetails()
                }
                
                List{
                    ForEach(details ?? []){
                        detail in
                        Text("Latitude: \(detail.latitude ?? ""), Longitude: \(detail.longitude ?? ""), Notes: \(detail.notes ?? "")")
                        image.scaledToFit()
                    }
                    .onDelete{
                        idx in deleteDetails(idx)
                    }
                }
                
                //Embed your list in a Navigation View with an editable title.
                //The Detail View also needs to contain a back button (typically displaying the name of the list) at the top left that takes the user back to the list (Master View)
                .navigationTitle(favouritePlace.place ?? "Details")
                .task{
                    fetchDetails()
                    checkMap()
                }
                
                            .navigationBarItems(
                                leading: EditButton()
                        
                            )
            }
        
        }
        .onAppear {
            /// start loading
            loading = true
            /// simulate loading delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                /// stop loading after delay
                loading = false
            }
            Task{
                image = await favouritePlace.getImage()
            }
        }
    }
    
    func addNewPlaceDetails(){
        guard name != "", url != "", latitude != "0.00000", longitude != "0.00000", notes != ""
        else{
            return
        }
        let placeDetails = Detail(context: ctx)
        
        //The Master View needs to be fully editable, i.e., you need to be able to edit elements.
        //All elements including the image URLs and notes need to be fully editable, i.e., you need to be able to add and edit elements.
        favouritePlace.place = name
        favouritePlace.strUrl = url
        placeDetails.latitude = latitude
        placeDetails.longitude = longitude
        placeDetails.notes = notes
        placeDetails.belongto = favouritePlace
        saveData()
        name = ""
        url = ""
        latitude = ""
        longitude = ""
        notes = ""
        Task{
            image = await favouritePlace.getImage()
        }

    }
    
    func fetchDetails(){
        let fetchRequest = Detail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "belongto = %@", favouritePlace)
        details = try? ctx.fetch(fetchRequest)
    }
    
    //All elements including the image URLs and notes need to be fully editable, i.e., you need to be able to remove elements.
    func deleteDetails(_ idx: IndexSet){
        guard let arr = details else {
            return
        }
        idx.map{arr[$0]}.forEach{ detail in
            ctx.delete(detail)
        }
            
        favouritePlace.imgurl = nil
        image = defaultImage
        
        saveData()
    }
     
    func checkLocation(){
        
    }
    
    func checkZoom(){
        
    }
    
    func checkMap(){
        model.updateFromRegion()
        latitude = model.latStr
        longitude = model.longStr
    }
}
