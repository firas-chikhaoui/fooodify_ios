//
//  DetailRepas.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI



struct DetailRepas : View {
    
    @State var count = 0
    @State var height = UIScreen.main.bounds.height
    @Binding var showDetailRepas : Bool
    @State var top = UIApplication.shared.windows.last?.safeAreaInsets.top
    @State var rep: Repas
    
    var body: some View{
        
                 ZStack{
                     
                     Color("Color").edgesIgnoringSafeArea(.all)
                     
                     VStack(spacing: 0){
                         
                        Image(rep.nom)
                             .resizable()
                           // .frame(height: UIScreen.main.bounds.height / 2.2)
                             .edgesIgnoringSafeArea(.top)
                             .overlay(
                         
                                 VStack{
                                     
                                     HStack(spacing: 12){
                                         
                                         Button(action: {
                                             
                                             self.showDetailRepas.toggle()
                                             
                                         }) {
                                             
                                             Image("back").renderingMode(.original)
                                         }.padding(.top,30)
                                         Spacer()
                                         
                                     }.padding()
                                     
                                     Spacer()
                                 }
                        )
                         ZStack(alignment: .topTrailing) {
                                 
                                 VStack{
                                     
                                     HStack{
                                         
                                        Text(rep.nom)
                                             .font(.title)
                                             .fontWeight(.bold)
                                             .foregroundColor(.black)
                                         
                                         Spacer()
                                         
                                     }.padding(.top, 25)
                                     
                                     HStack{
                                      Image("waiter").resizable().frame(width: 30, height: 30)
                                      Text("Restaurant").foregroundColor(.green)
                                       Spacer()
                                         
                                     }
                                     
                                     HStack(spacing: 10){
                                         
                                        Text(rep.description).foregroundColor(.gray)
                                            .frame(height: 80)
                                        
                                     }
                                     .padding(.top)
                                     
                                    HStack(spacing: 5){
                                     Image("deliver").resizable().frame(width: 30, height: 30)
                                      Text("Livraison")
                                                                             .fontWeight(.bold)
                                                                             .foregroundColor(Color("Color"))
                                                                             .padding(.top)
                                        
                                    }
                                                                         
                                     
                                     HStack(spacing: 18){
                                        
                                             
                                             VStack{
                                                 
                                                 Text("Gratuit")
                                             }
                                             .padding()
                                             .background(Color.white)
                                             .cornerRadius(10)
                                             .shadow(radius: 4)
                                         
                                     }
                                     .padding(.top)
                                    Spacer()
                                     
                                 }
                                 .padding(.bottom, 40)
                                 .padding(.horizontal,20)
                                 .background(CustomShape().fill(Color.white))
                                 .clipShape(Corners())

                         }
                         .zIndex(40)
                         .offset(y: -40)
                         .padding(.bottom, -40)
                         
                         HStack{
                             
                             VStack(alignment: .leading, spacing: 15) {
                                 
                                Text("Price").font(.title).foregroundColor(.black)
                                HStack(spacing: 5){
                                 Image("money").resizable().frame(width: 30, height: 30)
                                Text(rep.prix).font(.title).foregroundColor(.black)
                                    
                                }
                                 
                             }
                             .foregroundColor(.white)
                             .padding(.leading, 20)
                             
                             Spacer(minLength: 0)
                            
                            Button(action: {
                                
                                
                            }) {
                                
                                VStack{
                                    
                                    Text("Pay")
                                        .fontWeight(.bold)
                                    
                                    Text("Now")
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 25)
                                .background(Color.yellow)
                                .cornerRadius(15)
                                .shadow(radius: 4)
                            }
                            .padding(.trailing, 25)
                            .offset(y: -55)
                             
                         }
                         .zIndex(40)
                         .padding(.bottom, 10)
                        
                         
                     }
                     .edgesIgnoringSafeArea(.top)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                 }
       
        }
}
