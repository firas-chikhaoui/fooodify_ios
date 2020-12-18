//
//  Favoris.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI


struct Favoris : View {

@State var txt = ""
@ObservedObject var RestaurantListFavoris: RestaurantListFavorisViewModel = RestaurantListFavorisViewModel( )


var body : some View{
    
     VStack(spacing: 15){
             
        Header();

             ScrollView(.vertical, showsIndicators: false) {
                 
                 VStack(spacing: 15){
                     
                     
                     Image("top").resizable().overlay(
                     
                         VStack{
                             
                             Spacer()
                             
                             HStack{
                                 
                                 Text("GET 20% OFF").font(.title).foregroundColor(.white)
                                 Spacer()
                                 
                             }.padding()
                         }
                     
                     )
                                VStack(spacing: 15){
                                 ForEach(self.RestaurantListFavoris.restaurantsFav){restaurant in
                                     RestauCellView(data: restaurant)
                                     }
                                   }
                     
                 }
             }
             
         }.padding(.horizontal)
    }
}
