//
//  Repas.swift
//  tabbene
//
//  Created by tabbene mohamed on 06/06/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation



struct Repas : Codable,Hashable,Identifiable {
    
    var id : Int
    var nom : String
    var description : String
    var prix : String
}

typealias Repass = [Repas]

