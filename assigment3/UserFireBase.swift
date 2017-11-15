//
//  UserFireBase.swift
//  assigment3
//
//  Created by admin on 21/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage



class UserFirebase {
    
    static let instance = UserFirebase()
    
    init () {
        
        
      
        
    }
    
    
    //PUSH IT TO Fire Base (json files)
    func addUser(user: FIRUser!,st:User){
        let ref = FIRDatabase.database().reference().child("users").child(user.uid)
        ref.setValue(st.toFirebase())
        
    }
    
    //search by name the user UID of Firebase gave him and then return
    func getUserByUid(uid:String, callback:@escaping (User)->Void){
        
        let ref = FIRDatabase.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let json = snapshot.value as? Dictionary<String,String>
            let st = User(json: json!)
            callback(st)
        })
    
    }
    //all this funcs are Async so they continue with the normal program and when they finish they return callback
    func getAllUsers(callback:@escaping ([User])->Void){
        
        let ref = FIRDatabase.database().reference().child("users")
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            var users = [User]()
            
            for child in snapshot.children.allObjects{
                
                if let childData = child as? FIRDataSnapshot{
                    if let json = childData.value as? Dictionary<String,String>{
                        let st = User(json: json)
                        users.append(st)
                    }
                }
            }
            
            
            callback(users)
        })
}
}
