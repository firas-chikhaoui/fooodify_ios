//
//  Header.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI


struct Header : View {

 var body : some View{
    
 HStack(spacing: 12){
    
    Image("rp1").renderingMode(.original).resizable().frame(width: 30, height: 30)
    
    Text("Hi, Tabbene").font(.body)
    
    Spacer()
    
    Button(action: {
        
    }) {
        
        Image("filter").renderingMode(.original)
    }
}
}
    
}
