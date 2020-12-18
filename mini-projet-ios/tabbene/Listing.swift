//
//  Listing.swift
//  tabbene
//
//  Created by tabbene mohamed on 24/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI


struct Listing : View {

@State var txt = ""
@ObservedObject var RestaurantList: RestaurantListViewModel = RestaurantListViewModel( )

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
                                ForEach(self.RestaurantList.restaurants){restaurant in
                                        RestauCellView(data: restaurant)
                                    }
                                   }
                     
                 }
             }
             
         }.padding(.horizontal)
    }
}
