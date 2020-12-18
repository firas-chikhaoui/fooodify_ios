//
//  CellView.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI
import Combine


struct GategorieCellView : View {
    var data : Categorie
    @State var showGategorie = false

    
    var body : some View{

           HStack(spacing: 15){
                                      
           ZStack{
          NavigationLink(destination: ListRestauByCat(showGategorie: self.$showGategorie,cat: data), isActive: self.$showGategorie) {
           Text("")
           }
           VStack{
           Image(data.nom).renderingMode(.original)
            Text(data.nom)
           }.onTapGesture {
           self.showGategorie.toggle()
           }
           }
          }

    }
}

struct RestauHomeCellView : View {
    
    var data : Restaurant
    @State var showDetailRestau = false
    
    var body : some View{
        
        ZStack{

            NavigationLink(destination: DetailRestau(showDetailRestau: self.$showDetailRestau,rest: data), isActive:self.$showDetailRestau) {
                
                Text("")
            }
            VStack() {
                 Image(data.nom).resizable().frame(width: 100, height: 100).cornerRadius(10)
                 Text(data.nom).fontWeight(.semibold)
                 HStack{
                     Text(String(format: "%.1f", data.rating)).foregroundColor(.black)
                     
                  Image(systemName: "star.fill").foregroundColor(.yellow)
                  }
                 }
               }.onTapGesture {
                   
                   self.showDetailRestau.toggle()
               }
            
        }
}

struct RestauCellView : View {
    
    var data : Restaurant
    @State var showDetailRestau = false
    
    var body : some View{
        
        ZStack{

            NavigationLink(destination: DetailRestau(showDetailRestau: self.$showDetailRestau,rest: data), isActive:self.$showDetailRestau) {
                
                Text("")
            }

            HStack(spacing: 10){
                Image(data.nom).resizable().frame(width: 100, height: 100).cornerRadius(10)
                VStack(alignment: .leading){
                HStack{
                Text(data.nom).fontWeight(.semibold)
                Spacer()
                    if data.favoris == 0 {
                       Image(systemName: "heart").foregroundColor(.red).padding(.top,10)
                      } else {
                       Image(systemName: "heart.fill").foregroundColor(.red).padding(.top,10)
                    }
                }
                HStack{
                Image("marker").resizable().frame(width: 20, height: 20)
                    Text(data.adresse).foregroundColor(.gray).fontWeight(.semibold)
                }
                 HStack{
                    Text(String(format: "%.1f", data.rating)).foregroundColor(.black)
                    
                 Image(systemName: "star.fill").foregroundColor(.yellow)
                 }
                }.padding(.vertical, 10)
                 Spacer()
            }.onTapGesture {
                
                self.showDetailRestau.toggle()
            }
            
        }
    }
}



struct RepasGridCell: View {
  var repas: Repas
    @State var showDetailRepas = false
  var body: some View {
    ZStack{

        NavigationLink(destination: DetailRepas(showDetailRepas: self.$showDetailRepas,rep:repas), isActive: self.$showDetailRepas) {
                  
                  Text("")
              }
    VStack() {
      Image(repas.nom).resizable().frame(width: 130, height: 130).cornerRadius(10)
      Text(repas.nom).fontWeight(.semibold)
      Text(repas.prix).foregroundColor(.green)
    }.onTapGesture {
        
        self.showDetailRepas.toggle()
    }
  }
    }
}


struct AvisCellView : View {

var avis : Avis
@Binding var count_rating: Int
    
var body : some View{
     VStack{
    Text("Avis : ("+String(self.count_rating)+")").foregroundColor(.black).fontWeight(.bold)
    }.onAppear {
    self.count_rating = self.avis.total
    }
}
}
