//
//  ModelFireBase.swift
//  assigment3
//
//  Created by admin on 19/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseStorage


class RestaurantFirebase {
    
    
    
    static let instance = RestaurantFirebase()
    
init () {
    
    
   // FIRApp.configure()
    
    
}


//PUSH IT TO Fire Base (json files)
func addRestaurant(st:Restaurant){
    //let ref = FIRDatabase.database().reference().child("resturants").child(st.id!)
    let ref = FIRDatabase.database().reference().child("resturants").childByAutoId() //childbyAutoid() gives an random name by the asending with the alphabet
    ref.setValue(st.toFirebase())
    
}

////search by id the restaurant
//func getRestaurantById(id:String, callback:@escaping (Restaurant)->Void){
//    let ref = FIRDatabase.database().reference().child("restaurant").child(id)
//    ref.observeSingleEvent(of: .value, with: {(snapshot) in
//        let json = snapshot.value as? Dictionary<String,String>
//        let st = Restaurant(json: json!)
//        callback(st)
//    })
//}

//all this funcs are Async so they continue with the normal program and when they finish they return callback
func getAllRestaurants(callback:@escaping ([Restaurant])->Void){
    
    let ref = FIRDatabase.database().reference().child("resturants")
    
    ref.observeSingleEvent(of: .value, with: {(snapshot) in
        var restaurants = [Restaurant]()
        
        for child in snapshot.children.allObjects{
            
            if let childData = child as? FIRDataSnapshot{
                if let json = childData.value as? Dictionary<String,String>{
                    let st = Restaurant(json: json)
                    restaurants.append(st)
                }
            }
        }
        
        
        callback(restaurants)
    })
}
    
    
    
    
    
    
    
    
    
    
    
    // save Files in Storage FireBase (aka  stored in a Firebase Storage bucket) and return the downloadURL for the image
    
    
     lazy var storageRef = FIRStorage.storage().reference(forURL:
        "gs://bonappetit-89b91.appspot.com")
    
    func saveImageToFirebase(image:UIImage, name:(String),callback:@escaping (String?)->Void){

        // Create a reference to the file you want to upload name = ("images/rivers.jpg")
        let filesRef = storageRef.child(name)
        
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            
            filesRef.put(data, metadata: nil) { metadata, error in
                
                if (error != nil) {
                    
                    callback(nil)
                } else {

                     //// Metadata contains file metadata such as size, content-type, and download URL
                    let downloadURL = metadata!.downloadURL()
                    callback(downloadURL?.absoluteString)
                }
            }
        }
    }
    
    
    
    
}
