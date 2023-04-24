//
//  RowView.swift
//  AssignmentTwo
//
//  Created by jennifer-wei lin on 24/4/2023.
//

import SwiftUI

struct RowView: View {
    var favouritePlace : FavouritePlace
    @State var image = defaultImage
    var body: some View {
        HStack{
            image.frame(width:40, height:40).clipShape(Circle())
            Text(favouritePlace.place ?? "")
        }.task{
            image = await favouritePlace.getImage()
        }
    }
}

