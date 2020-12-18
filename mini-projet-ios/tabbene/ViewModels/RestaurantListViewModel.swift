//
//  RestaurantListViewModel.swift
//  tabbene
//
//  Created by tabbene mohamed on 24/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class RestaurantListViewModel:ObservableObject {
    @Published var restaurants: Restaurants = [Restaurant]()
    @Published var aviss: Aviss = [Avis]()
    init( ) {
        Webservice().getAllRest{
            self.restaurants = $0
          //  print(self.restaurants)
        }
    }
    
    //set Rating User Restau
    func setRatingUserRestau(IdRest:Int,Note:Int) {
        Webservice().setRatingUserRestau(IdRest: IdRest,Note: Note)
    }
    
      // @Published var NameCat : String = "Pizza"
       
       func getCountAvisWithId(IdRest:Int) {
         //  print(NameCat)
        Webservice().getCountAvisWithId(IdRest: IdRest){
               self.aviss = $0
          //  print(self.aviss)
           }
       }
    
    
    
}
