//
//  PostFireBase.swift
//  assigment3
//
//  Created by admin on 22/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import Firebase

class PostFireBase{
    
    static let instance = PostFireBase()
    
    init () {
    
    }
    
    
    
    //PUSH IT TO Fire Base (json files)
    func addPost(post: FIRUser!,st:Post){
        
        //we put random name with the with the childByAutoId eatch time its give a bigger name so in FB its become after it,  to save the post of the user

       // let ref = FIRDatabase.database().reference().child("posts").child(postId)
         let ref = FIRDatabase.database().reference().child("posts").childByAutoId()
        ref.setValue(st.toFirebase())
        
        
    }
    
    //search by name the user UID of Firebase gave him and then return
    func getPostByUid(uid:String, callback:@escaping (User)->Void){
        
        let ref = FIRDatabase.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let json = snapshot.value as? Dictionary<String,String>
            let st = User(json: json!)
            callback(st)
        })
        
    }
    //all this funcs are Async so they continue with the normal program and when they finish they return callback
    func getAllPosts(callback:@escaping ([Post])->Void){
        
        let ref = FIRDatabase.database().reference().child("posts")
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            var posts = [Post]()
            
            for child in snapshot.children.allObjects{
                
                if let childData = child as? FIRDataSnapshot{
                    if let json = childData.value as? Dictionary<String,String>{
                        let st = Post(json: json)
                        posts.append(st)
                    }
                }
            }
            
            
            callback(posts)
        })
    }

    
    
    
    
    
    
    // save Files in Storage FireBase (aka  stored in a Firebase Storage bucket)
    
    
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
    
    
    func getImageFromFirebase(url:String, callback:@escaping (UIImage?)->Void){
        let ref = FIRStorage.storage().reference(forURL: url)
        ref.data(withMaxSize: 10000000, completion: {(data, error) in
            if (error == nil && data != nil){
                let image = UIImage(data: data!)
                callback(image)
                }else{
                callback(nil)
            }
        })
    }
    
    
}
