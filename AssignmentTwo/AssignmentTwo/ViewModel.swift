//
//  ViewModel.swift
//  AssignmentTwo
//
//  Created by jennifer-wei lin on 24/4/2023.
//

import Foundation
import CoreData
import SwiftUI
import CoreLocation

let defaultImage = Image(systemName: "photo").resizable()
var downloadImages :[URL:Image] = [:]

extension FavouritePlace{
    var strUrl: String{
        get{
            self.imgurl?.absoluteString ?? ""
        }
        set {
            guard let url = URL(string: newValue) else {return}
            self.imgurl = url
        }
    }
    
    //function to get image
    func getImage() async -> Image {
        guard let url = self.imgurl else{return defaultImage}
        if let image = downloadImages[url] {return image}
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiimg = UIImage(data: data) else {return defaultImage}
            let image = Image(uiImage: uiimg).resizable()
            downloadImages[url] = image
            return image
        } catch {
            print("error in downloaded image \(error)")
        }
        return defaultImage
    }
    
}

//The purpose of this milestone to create an advanced Master/Detail app with persistent data using CoreData.
func saveData(){
    let ctx = PH.shared.container.viewContext
    do{
        try ctx.save()
    } catch {
        fatalError("save error with \(error)")
    }
}

extension MyLocation {
    var latStr: String{
        get{String(format: "%.5f", latitude)}
        set{
            guard let lat = Double(newValue), lat <= 90.0, lat >= -90.0 else
            {return}
            latitude = lat
        }
    }
    
    var longStr: String{
        get{String(format: "%.5f", longitude)}
        set{
            guard let long = Double(newValue), long <= 180.0, long >= -180.0 else
            {return}
            longitude = long
        }
    }
    
    func updateFromRegion(){
        latitude = region.center.latitude
        longitude = region.center.longitude
    }
    
    func setupRegion(){
        withAnimation{
            region.center.latitude = latitude
            region.center.longitude = longitude
            region.span.longitudeDelta = delta
            region.span.latitudeDelta = delta
        }
    }
    
    func fromLocToAddress(){
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { marks, error in
            if let err = error {
                print("error in fromLocToAddress \(err)")
                return
            }
            let mark = marks?.first
            let name = mark?.name ?? mark?.country ?? mark?.locality ?? mark?.administrativeArea ?? "No Name"
            self.name = name
        }
    }
    
    func fromZoomToDelta(_ zoom: Double ){
        let c1 = -10.0
        let c2 = 2.0
        delta = pow(10.0, zoom / c1 + c2)
    }
    
    func fromAddressToLocOld(_ cb: @escaping ()->Void){
        let encode = CLGeocoder()
        encode.geocodeAddressString(self.name) { marks, error in
            if let err = error {
                print("error in fromAddressToLoc \(err)")
                return
            }
            if let mark = marks?.first{
                self.latitude = mark.location?.coordinate.latitude ?? self.latitude
                self.longitude = mark.location?.coordinate.longitude ??
                    self.longitude
                cb()
                self.setupRegion()
            }
        }
    }
    
    func fromAddressToLoc() async {
        let encode = CLGeocoder()
        let marks = try? await encode.geocodeAddressString(self.name)
        
        if let mark = marks?.first{
            self.latitude = mark.location?.coordinate.latitude ?? self.latitude
            self.longitude = mark.location?.coordinate.longitude ?? self.longitude
            self.setupRegion()
        }
    }
    

}
