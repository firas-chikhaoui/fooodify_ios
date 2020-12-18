//
//  ListRestauByCat.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI


struct ListRestauByCat : View {

@State var txt = ""
@Binding var showGategorie : Bool
@State var top = UIApplication.shared.windows.last?.safeAreaInsets.top
@State var cat: Categorie
@ObservedObject var RestaurantListWithCat: RestaurantListWithCatViewModel = RestaurantListWithCatViewModel()
 var body : some View{
    
    VStack(spacing: 15){
                           VStack{
                               
                               HStack{
                                   
                                   Button(action: {
                                       
                                       self.showGategorie.toggle()
                                       
                                   }) {
                                       
                                       Image("back").renderingMode(.original)
                                   }
                                Spacer()
                               }
                             .overlay(
                            HStack{
                            Spacer()
                            Text(cat.nom)
                            .foregroundColor(.black)
                            Spacer()
                             }
                            )
                               
                           }


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
                     VStack{
                    HStack{
                     Text("Les restaurents "+cat.nom+" :").font(.title)
                     Spacer()
                    }
                    }
                    VStack(spacing: 15){
                        ForEach(self.RestaurantListWithCat.restaurantscat){restaurant in
                            RestauCellView(data: restaurant)
                        }
                     }.onAppear {
                        self.RestaurantListWithCat.loadrestwithcat(NameCat: self.cat.nom)
                     }
                     
                 }
             }
         .navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
             
         }.padding(.horizontal)
    }
}

