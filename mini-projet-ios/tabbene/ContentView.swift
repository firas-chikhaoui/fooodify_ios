//
//  ContentView.swift
//  tabbene
//
//  Created by tabbene mohamed on 29/04/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI


var tabs = ["Home","Favoris","Listing"]

struct ContentView: View {
    
   @State var selected = "Login"
    
    var body: some View {
        
        NavigationView{
            
            
            VStack{
                
                if self.selected == "Home"{
                    
                    Home()
                    CustomTabView(selected: $selected)
                }
                else if self.selected == "Favoris"{
                    
                     Favoris()
                    CustomTabView(selected: $selected)
                }
                else if self.selected == "Listing"{
                    
                   Listing()
                   CustomTabView(selected: $selected)
                }
                else{
                    LoginPage()
                }
                
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

struct CustomTabView : View {
    
    @Binding var selected : String
    
    var body : some View{
        
        HStack{
            
            ForEach(tabs,id: \.self){i in
                
                VStack(spacing: 10){
                    
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 5)
                        .overlay(
                    
                            Capsule().fill(self.selected == i ? Color("Color") : Color.clear).frame(width: 55, height: 5)
                         )
                    
                    Button(action: {
                        
                        self.selected = i
                        
                    }) {
                        
                        VStack{
                            
                            Image(i).renderingMode(.original)
                            Text(i).foregroundColor(.black)
                        }
                    }
                }
            }
            
        }.padding(.horizontal)
    }
}







