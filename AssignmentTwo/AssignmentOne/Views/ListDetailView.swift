//
//  ListDetailView.swift
//  AssignmentOne
//
//  Created by jennifer-wei lin on 17/3/2023.
//

import SwiftUI

///The ListDetailView struct is the Detail View for the items within each checklist

struct ListDetailView: View {

    @Environment(\.managedObjectContext) var ctx
    var favouriteplace: FavouritePlace

    @State var loading = false /// State variable to indicate loading status
    
    var body: some View {
        Group {
            if loading { /// Show ProgressView if loading is true
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else { /// Show List if loading is false
                List{
                    

                }
                
                .navigationTitle(favouriteplace.place ?? "Tests")
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
        }
    }
}
