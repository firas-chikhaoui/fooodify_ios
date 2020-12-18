//
//  Restaurant.swift
//  tabbene
//
//  Created by tabbene mohamed on 21/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation

struct Restaurant : Codable,Hashable,Identifiable {
    let id : Int
    let nom : String
    let adresse: String
    let rating: Double
    let delivery: String
    let favoris: Int
}
typealias Restaurants = [Restaurant]
