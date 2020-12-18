//
//  Webservice.swift
//  tabbene
//
//  Created by tabbene mohamed on 19/05/2020.
//  Copyright © 2020 Tabbene mohamed. All rights reserved.
//

import Foundation
import SwiftUI


class Webservice {
    let URLAPI="http://192.168.43.218:4000";
    
    //categories
    func getAllCat(completion: @escaping ([Categorie]) -> ()) {
        guard let url = URL(string: URLAPI+"/getAllCat/")
          else {
          fatalError("URL is not correct !!!")
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
           
            let categories = try!
                JSONDecoder().decode([Categorie].self, from: data!)
            DispatchQueue.main.async {
                completion(categories)
            }
           // print(categories)
            
        }.resume()
    }
    
    //restaurants with categorie
    func getAllRestwithCat(NameCat: String, completion: @escaping ([Restaurant]) -> ()) {
        guard let url = URL(string: URLAPI+"/getAllRestwithCat/"+NameCat+"/med")
          else {
          fatalError("URL is not correct !!!")
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
           
            let restaurantscat = try!
                JSONDecoder().decode([Restaurant].self, from: data!)
            DispatchQueue.main.async {
                completion(restaurantscat)
            }
            
        }.resume()
    }
    
    //restaurants with Favoris
       func getRestwithUser(completion: @escaping ([Restaurant]) -> ()) {
           guard let url = URL(string: URLAPI+"/getRestwithUser/med")
             else {
             fatalError("URL is not correct !!!")
           }

           URLSession.shared.dataTask(with: url) { data, _, _ in
              
               let restaurantsFav = try!
                   JSONDecoder().decode([Restaurant].self, from: data!)
               DispatchQueue.main.async {
                   completion(restaurantsFav)
               }
               
           }.resume()
       }
    
    
    //restaurants
    func getAllRest(completion: @escaping ([Restaurant]) -> ()) {
        guard let url = URL(string: URLAPI+"/getAllRest/med")
          else {
          fatalError("URL is not correct !!!")
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
           
            let restaurants = try!
                JSONDecoder().decode([Restaurant].self, from: data!)
            DispatchQueue.main.async {
                completion(restaurants)
            }
            
        }.resume()
    }
  
    //repas with rest
     func getAllRepaswithRest(IdRest: Int, completion: @escaping ([Repas]) -> ()) {
        guard let url = URL(string: URLAPI+"/getAllRepaswithId/"+String(IdRest))
          else {
          fatalError("URL is not correct !!!")
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
           
            let repass = try!
                JSONDecoder().decode([Repas].self, from: data!)
            DispatchQueue.main.async {
                completion(repass)
            }
            
        }.resume()
    }
    
    
    //set Favorite User Restau
     func setFavoriteUserRestau(IdRest: Int) {
       // print(IdRest)
        guard let url = URL(string: URLAPI+"/setFavoriteUserRestau/"+String(IdRest)+"/med")
          else {
          fatalError("URL is not correct !!!")
        }
        URLSession.shared.dataTask(with: url).resume()
    }
    
    
    //delete Favorite User Restau
    func deleteFavoriteUserRestau(IdRest: Int) {
         //  print(IdRest)
           guard let url = URL(string: URLAPI+"/deleteFavoriteUserRestau/"+String(IdRest)+"/med")
             else {
             fatalError("URL is not correct !!!")
           }
           URLSession.shared.dataTask(with: url).resume()
       }
    
   //set Rating User Restau
    func setRatingUserRestau(IdRest: Int,Note: Int) {
         //  print(IdRest)
           guard let url = URL(string: URLAPI+"/setRatingUserRestau/"+String(IdRest)+"/"+String(Note)+"/med")
             else {
             fatalError("URL is not correct !!!")
           }
           URLSession.shared.dataTask(with: url).resume()
       }
    
    
    //get Count Avis With Id Rest
       func getCountAvisWithId(IdRest: Int, completion: @escaping ([Avis]) -> ()){
            //  print(IdRest)
              guard let url = URL(string: URLAPI+"/getCountAvisWithId/"+String(IdRest))
                else {
                fatalError("URL is not correct !!!")
              }
               URLSession.shared.dataTask(with: url) { data, _, _ in
                        
                         let aviss = try!
                             JSONDecoder().decode([Avis].self, from: data!)
                         DispatchQueue.main.async {
                             completion(aviss)
                         }
                         
             }.resume()
          }
    
    
}



