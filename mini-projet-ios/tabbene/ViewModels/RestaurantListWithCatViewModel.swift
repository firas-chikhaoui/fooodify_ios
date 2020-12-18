//
//  RestaurantListViewModel.swift
//  tabbene
//
//  Created by tabbene mohamed on 21/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class RestaurantListWithCatViewModel:ObservableObject{
    @Published var restaurantscat: Restaurants = [Restaurant]()

    
    func loadrestwithcat(NameCat:String) {
      //  print(NameCat)
        Webservice().getAllRestwithCat(NameCat: NameCat){
            self.restaurantscat = $0
        }
    }
    
    
}
