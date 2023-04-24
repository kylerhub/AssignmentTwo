//
//  ViewModel.swift
//  AssignmentTwo
//
//  Created by jennifer-wei lin on 24/4/2023.
//

import Foundation
import CoreData
import SwiftUI

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

func saveData(){
    let ctx = PH.shared.container.viewContext
    do{
        try ctx.save()
    } catch {
        fatalError("save error with \(error)")
    }
}
