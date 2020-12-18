//
//  RepasListWithRestViewModel.swift
//  tabbene
//
//  Created by tabbene mohamed on 06/06/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class RepasListWithRestViewModel:ObservableObject{
    @Published var repasrest: Repass = [Repas]()

   // @Published var NameCat : String = "Pizza"
    
    func loadrepaswithrest(IdRest:Int) {
      //  print(NameCat)
        Webservice().getAllRepaswithRest(IdRest: IdRest){
            self.repasrest = $0
        }
    }
    
}
