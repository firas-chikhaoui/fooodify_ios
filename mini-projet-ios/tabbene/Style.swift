//
//  Style.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI


struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        
        return Path{path in

            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 40))
            
        }
    }
}


struct RoundedCorner : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

struct Corners : Shape {
     
     func path(in rect: CGRect) -> Path {
         
         let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
         
         return Path(path.cgPath)
     }
 }
 
 class Host: UIHostingController<ContentView> {
     
     override var preferredStatusBarStyle: UIStatusBarStyle{
         
         return .lightContent
     }
     
     override var prefersHomeIndicatorAutoHidden: Bool{
         
         return true
     }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding(.top).padding(.bottom).padding(.horizontal, 20)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(50.0)
    }
}
