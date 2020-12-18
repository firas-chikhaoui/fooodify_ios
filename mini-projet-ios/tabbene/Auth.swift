//
//  Auth.swift
//  tabbene
//
//  Created by tabbene mohamed on 16/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON



struct LoginPage : View {
     
     @State var index = 0
     
     var body : some View{
         
        ZStack{
        
        LinearGradient(gradient: .init(colors: [Color("Color-1"),Color("Color1-1"),Color("Color2-1")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
         VStack{
             
             Image("logo")
             .resizable()
             .frame(width: 200, height: 180)
             
             HStack{
                 
                 Button(action: {
                     
                     withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                         
                        self.index = 0
                     }
                     
                 }) {
                     
                     Text("Existing")
                         .foregroundColor(self.index == 0 ? .black : .white)
                         .fontWeight(.bold)
                         .padding(.vertical, 10)
                         .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                     
                 }.background(self.index == 0 ? Color.white : Color.clear)
                 .clipShape(Capsule())
                 
                 Button(action: {
                     
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                       self.index = 1
                    }
                     
                 }) {
                     
                     Text("New")
                         .foregroundColor(self.index == 1 ? .black : .white)
                         .fontWeight(.bold)
                         .padding(.vertical, 10)
                         .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                     
                 }.background(self.index == 1 ? Color.white : Color.clear)
                 .clipShape(Capsule())
                 
             }.background(Color.black.opacity(0.1))
             .clipShape(Capsule())
             .padding(.top, 25)
             
             if self.index == 0{
                 
                 Login(index: self.$index)
             }
             else{
                 
                 SignUp(index: self.$index)
             }
             
             if self.index == 0{
                 
                 Button(action: {
                    
                    
                    
                     
                 }) {
                     
                     Text("Forget Password?")
                         .foregroundColor(.white)
                 
                 }
                 .padding(.top, 20)
             }
             
             HStack(spacing: 15){
                 
                 Color.white.opacity(0.7)
                 .frame(width: 35, height: 1)
                 
                 Text("Or")
                     .fontWeight(.bold)
                     .foregroundColor(.white)
                 
                 Color.white.opacity(0.7)
                 .frame(width: 35, height: 1)
                 
             }
             .padding(.top, 10)
             
             HStack{
                 
                 Button(action: {
                     
                 }) {
                     
                     Image("fb")
                         .renderingMode(.original)
                         .padding()
                     
                 }.background(Color.white)
                 .clipShape(Circle())
                 
                 Button(action: {
                     
                 }) {
                     
                     Image("google")
                         .renderingMode(.original)
                         .padding()
                     
                 }.background(Color.white)
                 .clipShape(Circle())
                 .padding(.leading, 25)
             }
             .padding(.top, 10)
             
         }
         .padding()
     }
 }
}
 
 struct Login : View {
     
    @State var name = ""
     @State var email = ""
      @State var pass = ""
     
      @Binding var index : Int
      @State var showAlert = false
      @State var registerHeader = ""
      @State var registerBody = ""
    @State var showLoginView: Bool = false

     
     var body : some View{
         
         VStack{
             
             VStack{
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "envelope")
                         .foregroundColor(.black)
                     
                     TextField("Enter Email Address", text: self.$name)
                     
                 }.padding(.vertical, 20)
                 
                 Divider()
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "lock")
                     .resizable()
                     .frame(width: 15, height: 18)
                     .foregroundColor(.black)
                     
                     SecureField("Password", text: self.$pass)
                     
                  
                     
                     {
                         
                         Image(systemName: "eye")
                             .foregroundColor(.black)
                     }
                     
                 }.padding(.vertical, 20)
                 
             }
             .padding(.vertical)
             .padding(.horizontal, 20)
             .padding(.bottom, 40)
             .background(Color.white)
             .cornerRadius(10)
             .padding(.top, 25)
             
            Button(action: {
                                 let paramaters = ["name":self.name,"password":self.pass]
                
                                 AF.request("http://192.168.43.218:4000/login33/",method: .post,parameters: paramaters)
                                 .validate()
                                 .responseJSON{response in
                                 switch response.result {
                                 case .success:
                                     do {
                                         let user = try JSONDecoder().decode(User.self, from: response.data!)
                                         print(user)
                                            self.showLoginView = true

                                     } catch let error as NSError {
                                         print("Failed to load: \(error.localizedDescription)")
                                     }
                                 
                                 case let .failure(error):
                                     print(error)
                                     print("hhhh")
                                     print(self.name+"fffffff")
                                     self.showAlert = true
                                     self.registerHeader = "Please try again"
                                     self.registerBody = "Email or password incorrect"
                                     }}
                                  
                              })
            {
                           
                           Text("LOGIN")
                           .foregroundColor(.white)
                           .fontWeight(.bold)
                           .padding(.vertical)
                           .frame(width: UIScreen.main.bounds.width - 100)
                }.background(
                 
                LinearGradient(gradient: .init(colors: [Color("Color2-1"),Color("Color1-1"),Color("Color-1")]), startPoint: .leading, endPoint: .trailing)
                 )
                 .cornerRadius(8)
                 .offset(y: -40)
                 .padding(.bottom, -40)
                 .shadow(radius: 15)
            NavigationLink(destination: ContentView(selected: "Home"), isActive: $showLoginView) {
                           EmptyView()
                               }
                    
             
         }
     }
 }

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
 
 struct SignUp : View {
     
     
     @State var pass = ""
     
    @State var email = ""
    @State var name = ""
    @State var Repass = ""
    @Binding var index : Int
    @State var showAlert = false
    @State var registerHeader = ""
    @State var registerBody = ""
     
     var body : some View{
         
         VStack{
             
             VStack{
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "envelope")
                         .foregroundColor(.black)
                     
                     TextField("Enter Email Address", text: self.$email)
                     
                 }.padding(.vertical, 20)
                 
                 Divider()
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "lock")
                     .resizable()
                     .frame(width: 15, height: 18)
                     .foregroundColor(.black)
                     
                     TextField("user name", text: self.$name)
                     
                     Button(action: {
                         
                     }) {
                         
                         Image(systemName: "eye")
                             .foregroundColor(.black)
                     }
                     
                 }.padding(.vertical, 20)
                 
                 Divider()
                 
                 HStack(spacing: 15){
                     
                     Image(systemName: "lock")
                     .resizable()
                     .frame(width: 15, height: 18)
                     .foregroundColor(.black)
                     
                     SecureField("password", text: self.$Repass)
                     
                     Button(action: {
                         
                     }) {
                         
                         Image(systemName: "eye")
                             .foregroundColor(.black)
                     }
                     
                 }.padding(.vertical, 20)
                 
             }
             .padding(.vertical)
             .padding(.horizontal, 20)
             .padding(.bottom, 40)
             .background(Color.white)
             .cornerRadius(10)
             .padding(.top, 25)
             
             
             Button(action: {
                
                var emaill : String
                if (self.email.isValidEmail() && self.Repass.isValidPassword() && self.name != ""){
                    emaill = (self.email ) as String
                    let paramaters = ["email":emaill,"name":self.name]
                    let paramaters1 = ["email":emaill,"password":self.Repass , "name":self.name]
                        AF.request("http://192.168.43.218:4000/checkNameEmail",method: .post,parameters: paramaters)
                                       .validate()
                                       .responseJSON{response in
                    switch response.result {
                    case .success:
                            do {
                    let user = try JSONDecoder().decode(User.self, from: response.data!)
                            print(user)
                            self.showAlert = true
                            self.registerHeader = "Register Failed"
                        self.registerBody = "Email or password already exists"
                                               
                            } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                            }
                                       
                        case let .failure(error):
                            print(error)
                                           
                        AF.request("http://192.168.43.218:4000/register33/",method: .post,parameters: paramaters1)
                            .validate()
                        .responseJSON{response in
                                switch response.result {
                                        case .success:
                                                                 
                                do {
                                    self.showAlert = true
                                self.registerHeader = "Register accomplished"
                                    self.registerBody = "Account created, please log in "
                                        }
                                case let .failure(error):
                                    print(error)
                                    print("here")
                                                                       
                                    }
                                }
                                           
                                           }}
                }else{
                    self.showAlert = true
                    self.registerHeader = "notice!"
                    self.registerBody = "invalid email or password, password must be longer than 7, UpperCase and numeric character "
                }
                 
             }) {
                 
                 Text("SIGNUP")
                     .foregroundColor(.white)
                     .fontWeight(.bold)
                     .padding(.vertical)
                     .frame(width: UIScreen.main.bounds.width - 100)
                 
             }.background(
             
                 LinearGradient(gradient: .init(colors: [Color("Color2-1"),Color("Color1-1"),Color("Color-1")]), startPoint: .leading, endPoint: .trailing)
             )
             .cornerRadius(8)
             .offset(y: -40)
             .padding(.bottom, -40)
             .shadow(radius: 15)
         }
     }
 }

