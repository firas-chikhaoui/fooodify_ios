//
//  Categorie.swift
//  tabbene
//
//  Created by tabbene mohamed on 19/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation



struct Categorie : Codable,Hashable,Identifiable {
    let id : Int
    let nom : String
}
typealias Categories = [Categorie]

