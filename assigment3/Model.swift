//
//  Model.swift
//  assigment3
//
//  Created by admin on 18/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit



//This model for Firebase
class Model{
    
    static let instance = Model()

    
    lazy private var modelSql:ModelSQL? = ModelSQL()
    lazy private var modelFirebase:RestaurantFirebase? = RestaurantFirebase() //(modelFirebase is just a var that represent RestaurantFirebase)
    
    
    
    private init () {

        
    }
    
    
    func addRestaurant(st:Restaurant){
        
      
      st.addRestaurant(database: modelSql?.database)
        
    }
    
   
    func getRestaurantById(id:String, callback:@escaping (Restaurant)->Void){
  
    }
    
    func getAllRestaurants(callback:@escaping ([Restaurant])->Void){
        
        
        
        let restaurants = Restaurant.getAllRestaurants(database:modelSql?.database)
        
        
        callback(restaurants)
    }
    
 
    
    func getImageFromFileLocal(name:String?)-> UIImage? {
        return getImageFromFile(name: name!)
    }
    
    
    
   func saveImageToFileLocal(image:UIImage,name:String){
    saveImageToFile(image: image, name: name)
    
    }
    
    
    
    
    //local
    
    private func saveImageToFile(image:UIImage, name:String){
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent(name)
            try? data.write(to: filename)
        }
    }
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    
    private func getImageFromFile(name:String)->UIImage?{
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile:filename.path)
    }
    
    
    
    
    
    
    
    
    //firebase
    
    func saveImageToFireBaseStorage (image:UIImage , name:String,   callback: @escaping (String?)->Void?) {
        
        
        modelFirebase?.saveImageToFirebase(image: image, name: name, callback: { (url) in

            
            if (url != nil)
            {
                    callback(url)
                    print("url: \(url)")
            }
          
        
        })
        
}
    
    
    func addRestaurantToFireBase(st:Restaurant){
        
        modelFirebase?.addRestaurant(st: st)
        
        
    }
    
    

}
    

