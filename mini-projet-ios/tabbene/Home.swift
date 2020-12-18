//
//  Home.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI


struct Home : View {
    @State var txt = ""
    @State var showHome = false
   // @State var categories : [Categorie] = []
   @ObservedObject var CategoriesList: CategorieListViewModel = CategorieListViewModel( )
    
    var body : some View{
        
        VStack(spacing: 15){
            
            Header();
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15){
                    
                    HStack(spacing: 15){
                        
                        
                        HStack{
                            
                            Image(systemName: "magnifyingglass").font(.body)
                            
                            TextField("Search repas", text: $txt)
                            
                        }.padding(10)
                        .background(Color("Color1"))
                        .cornerRadius(20)

                    }
                    
                    Image("top").resizable().overlay(
                    
                        VStack{
                            
                            Spacer()
                            
                            HStack{
                                
                                Text("GET 20% OFF").font(.title).foregroundColor(.white)
                                Spacer()
                                
                            }.padding()
                        }
                    
                    )
                    
                    HStack{

                        Text("Categories").font(.title)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            
                            Text("More")
                            
                        }.foregroundColor(Color("Color"))
                        
                    }.padding(.vertical, 15)
                    
                   
                     ScrollView(.horizontal, showsIndicators: false) {
                     HStack(spacing: 15){
                        ForEach(self.CategoriesList.categories){categorie in
                          GategorieCellView(data: categorie)
                             }
                     }.frame(height:95)
                    }
                    
                   HomeBottomView()
                    
                    
                }
            }
            
        }.padding(.horizontal)
 
    }
}

// Home bottom

 struct HomeBottomView : View {
    
    @ObservedObject var RestaurantList: RestaurantListViewModel = RestaurantListViewModel( )
    @ObservedObject var RestaurantListFavoris: RestaurantListFavorisViewModel = RestaurantListFavorisViewModel( )

    
    var body : some View{
        
        VStack(spacing: 15){
            
            HStack{

                Text("Last Restaurants").font(.title)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Text("More")
                    
                }.foregroundColor(Color("Color"))
                
            }.padding(.vertical, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15){
                      ForEach(self.RestaurantList.restaurants){restaurant in
                       RestauHomeCellView(data: restaurant)
                     }
                }.frame(height:200)
            }
            
            HStack{

                Text("Last Restaurants Favoris").font(.title)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Text("More")
                    
                }.foregroundColor(Color("Color"))
                
            }.padding(.vertical, 15)
            
           ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15){
                   ForEach(self.RestaurantListFavoris.restaurantsFav){restaurant in
                      RestauHomeCellView(data: restaurant)
                    }
                }.frame(height:200)
            }
        }
    }
}
