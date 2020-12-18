//
//  Avis.swift
//  tabbene
//
//  Created by tabbene mohamed on 08/06/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation



struct Avis : Codable,Hashable,Identifiable {
    
   let id : Int
   let total : Int
}

typealias Aviss = [Avis]
