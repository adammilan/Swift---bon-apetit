//
//  User.swift
//  assigment3
//
//  Created by admin on 21/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import Firebase

class User {
    
   // var id: String?
    var username:String?
    var email:String?
    var password:String?
    
    var user: FIRUser? //this actually give us the uid of the firebase
    
    
    
    var userPhotoURL:String?
    
    
    init(username: String?, email:String? , password:String?, user: FIRUser) {
    
        
        
        self.username = username
        self.email   = email
        self.password = password
        self.user = user
       
        
    }
    
    
    
    
    
    init?(username: String?, email:String?, password:String?) {
        
        
        
        self.username = username
        self.email   = email
        self.password = password
    }
    
    
    
    
    init?(username: String?, email:String?, password:String?,userPhotoURL:String?) {
        
        
        
        self.username = username
        self.email   = email
        self.password = password
        self.userPhotoURL = userPhotoURL
        
    }
    
    
    
    
    
    
    //This is from what comes back for getResturantById cuz we need to take the json files that come from the firebase and make them var's again
    
    init(json:Dictionary<String,String>){
        
        

        password = json["password"]
        username   = json["username"]!
        email = json["email"]
        userPhotoURL = json["userPhotoURL"]
        
        
    }
    
    
    
    //before sending the details we need to put them in json files and send upload the json file of each resturant to FB
    func toFirebase() -> Dictionary<String,String> {
        var json = Dictionary<String,String>()
        json["password"] = password
        json["username"] = username
        json["email"] = email
        json["userPhotoURL"] = userPhotoURL
        
        return json
    }
    
}

