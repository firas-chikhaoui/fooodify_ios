//
//  RestaurantListFavorisViewModel.swift
//  tabbene
//
//  Created by tabbene mohamed on 24/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//
import Foundation
import SwiftUI
import Combine

final class RestaurantListFavorisViewModel:ObservableObject {
    @Published var restaurantsFav: Restaurants = [Restaurant]()
    init( ) {
        Webservice().getRestwithUser{
            self.restaurantsFav = $0
          //  print(self.restaurants)
        }
    }
    
    func setFavoriteUserRestau(IdRest:Int) {
     // print(IdRest)
        Webservice().setFavoriteUserRestau(IdRest: IdRest)
    }
    func deleteFavoriteUserRestau(IdRest:Int) {
     // print(IdRest)
        Webservice().deleteFavoriteUserRestau(IdRest: IdRest)
    }
    
}

