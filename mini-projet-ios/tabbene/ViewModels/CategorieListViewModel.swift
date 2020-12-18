//
//  CategorieListViewModel.swift
//  tabbene
//
//  Created by tabbene mohamed on 19/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class CategorieListViewModel:ObservableObject {
    
    @Published var categories: Categories = [Categorie]()
    init() {
        Webservice().getAllCat{
            self.categories = $0
          //  print(self.categories)
        }
    }
}
