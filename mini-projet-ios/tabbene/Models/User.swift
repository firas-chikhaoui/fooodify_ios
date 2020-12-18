//
//  User.swift
//  tabbene
//
//  Created by ESPRIT on 6/26/20.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI

struct User: Identifiable, Decodable, Equatable {
    
    var id: Int?
    var name: String
    var email: String?
    var password: String?
    
    
    
}
