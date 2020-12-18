//
//  DetailRestau.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI
import QGrid

struct DetailRestau : View {
    
    @Binding var showDetailRestau : Bool
    @State var top = UIApplication.shared.windows.last?.safeAreaInsets.top
    @State var rest: Restaurant
    @ObservedObject var RepasListWithRest: RepasListWithRestViewModel = RepasListWithRestViewModel()
    @ObservedObject var RestaurantListFavoris: RestaurantListFavorisViewModel = RestaurantListFavorisViewModel()
    @ObservedObject var RestaurantList: RestaurantListViewModel = RestaurantListViewModel()

    
    
    @State var fav = 0
    @State var count_rating : Int = 0
    @State var valeur_rating = 0.0
    
    
    var body : some View{
        
        VStack(spacing: 0){
            
            Image(self.rest.nom)
                .resizable()
                .frame(height: UIScreen.main.bounds.height / 3)
                .edgesIgnoringSafeArea(.top)
                .overlay(
            
                    VStack{
                        
                        HStack(spacing: 12){
                            
                            Button(action: {
                                
                                self.showDetailRestau.toggle()
                                
                            }) {
                                
                                Image("back").renderingMode(.original)
                            }
                            
                            Spacer()

                            
                            if self.fav == 0 {
                                Button(action: {
                                    self.RestaurantListFavoris.setFavoriteUserRestau(IdRest: self.rest.id)
                                    self.fav = 1
                                }) {
                                  Image(systemName: "heart").foregroundColor(.red).font(.largeTitle)
                                }
                                
                            } else {
                            Button(action: {
                                self.RestaurantListFavoris.deleteFavoriteUserRestau(IdRest: self.rest.id)
                                  self.fav = 0
                             }) {
                              Image(systemName: "heart.fill").foregroundColor(.red).font(.largeTitle)
                            }
                                                           
                           }
                            
                            
                        }.padding()
                        Spacer()
                    }
            
                )
            
            
            VStack {
                
                VStack(alignment: .leading,spacing: 5){
                    
                    Text(rest.nom).font(.title)
                                        
                    Divider().padding(.vertical, 5)
                    
                    HStack(spacing: 5){
                     Image("marker").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
                        Text(rest.adresse).foregroundColor(.gray).fontWeight(.semibold)
                    }
                    HStack(spacing: 15){
                        Image(systemName: "stopwatch")
                        Text("Du 9h à 23h")
                    }
                    .foregroundColor(.gray)
                    VStack(spacing: 15){
                        HStack{
                            ForEach(self.RestaurantList.aviss){avis in
                                AvisCellView(avis: avis,count_rating: self.$count_rating)
                            }
                            Spacer()
                        }
                        HStack{
                        Button(action: {
                            self.RestaurantList.setRatingUserRestau(IdRest: self.rest.id, Note: 1)
                            let exp1 = (Double(self.count_rating) * self.rest.rating) + 1
                            let res_exp1 = (exp1 / Double(self.count_rating + 1))
                            self.valeur_rating = Double(String(format: "%.1f", res_exp1))!
                            self.count_rating = self.count_rating + 1
                        }) {
                          Text("1")
                        }.buttonStyle(GradientButtonStyle())
                        Button(action: {
                           self.RestaurantList.setRatingUserRestau(IdRest: self.rest.id, Note: 2)
                            let exp2 = (Double(self.count_rating) * self.rest.rating) + 2
                            let res_exp2 = (exp2 / Double(self.count_rating + 1))
                            self.valeur_rating = Double(String(format: "%.1f", res_exp2))!
                            self.count_rating = self.count_rating + 1
                        }) {
                          Text("2")
                        }.buttonStyle(GradientButtonStyle())
                        Button(action: {
                           self.RestaurantList.setRatingUserRestau(IdRest: self.rest.id, Note: 3)
                            let exp3 = (Double(self.count_rating) * self.rest.rating) + 3
                            let res_exp3 = (exp3 / Double(self.count_rating + 1))
                            self.valeur_rating = Double(String(format: "%.1f", res_exp3))!
                           self.count_rating = self.count_rating + 1
                        }) {
                          Text("3")
                        }.buttonStyle(GradientButtonStyle())
                    Button(action: {
                                      self.RestaurantList.setRatingUserRestau(IdRest: self.rest.id, Note: 4)
                        let exp4 = (Double(self.count_rating) * self.rest.rating) + 4
                        let res_exp4 = (exp4 / Double(self.count_rating + 1))
                        self.valeur_rating = Double(String(format: "%.1f", res_exp4))!
                        self.count_rating = self.count_rating + 1
                                           }) {
                                             Text("4")
                                           }.buttonStyle(GradientButtonStyle())
                    Button(action: {
                                       self.RestaurantList.setRatingUserRestau(IdRest: self.rest.id, Note: 5)
                        let exp5 = (Double(self.count_rating) * self.rest.rating) + 5
                        let res_exp5 = (exp5 / Double(self.count_rating + 1))
                        self.valeur_rating = Double(String(format: "%.1f", res_exp5))!
                        self.count_rating = self.count_rating + 1
                                           }) {
                                             Text("5")
                    }.buttonStyle(GradientButtonStyle())
                             Spacer()
                    }
                   }.frame(height: 100)
                    
                    Text("Notre repas :").foregroundColor(.black).fontWeight(.bold)
                  
                  /*  QGrid(self.RepasListWithRest.repasrest, columns: 2) { RepasGridCell(repas: $0) }
                     .edgesIgnoringSafeArea(.all)
                        .frame(height: UIScreen.main.bounds.height / 2.4)
                    .onAppear {
                        self.RepasListWithRest.loadrepaswithrest(IdRest: self.rest.id)
                    } */
                    
                    VStack(spacing: 15){
                       ForEach(self.RepasListWithRest.repasrest){repas in
                        RepasGridCell(repas: repas)
                       }
                    }.onAppear {
                       self.RepasListWithRest.loadrepaswithrest(IdRest: self.rest.id)
                       self.RestaurantList.getCountAvisWithId(IdRest: self.rest.id)
                        
                       self.fav = self.rest.favoris
                       self.valeur_rating = Double(String(format: "%.1f", self.rest.rating))!
                    }
                    
                }

               
            }.padding()
            .overlay(
            
            
                VStack{
                    
                    HStack{
                        
                        Spacer()
                        
                        HStack{
                            
                            Text(String(valeur_rating)).foregroundColor(.white)
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            
                        }.padding()
                        .background(Color.green)
                        .cornerRadius(12)
                    }
                    .padding(.top,-20)
                    .padding(.trailing)
                        
                 Spacer()
                }
            
            )
            .background(RoundedCorner().fill(Color.white))
            .padding(.top, -top! - 25)
                
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            Spacer()
            
        }
    }
}


