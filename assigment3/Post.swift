//
//  Post.swift
//  assigment3
//
//  Created by admin on 22/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Post{


    var postImage: UIImage? //post the image
   var userImage: UIImage?
   // var postId: String?
    var content: String?
    
    var username: String?
    
    var userImageURL:String?
    var postImageURL:String?
    
    
    
    
    
    
    var email:String?
    
     var user: FIRUser? //this actually give us the uid of the firebase
    
    
    
    
    init?(username:String?,content:String?,userimage:UIImage?,postImage:UIImage?) {
        
        self.username = username
        self.content = content
        self.userImage = userimage
        self.postImage = postImage
        
        
        
        //Initlization should fail if there is no name or id correct
        if (username?.isEmpty)! || (content?.isEmpty)! {
            
            return nil
        }

        
    }
    
    
    init?(username:String?,content:String?,userimage:UIImage?,postImage:UIImage?, user: FIRUser) {
        
        self.username = username
        self.content = content
        self.userImage = userimage
        self.postImage = postImage
        self.user = user
    }
    
    
    
    
    
    init?(username:String?,content:String?,userimageURL:String?,postImageURL:String?) {
        
        self.username = username
        self.content = content
        self.userImageURL = userimageURL
        self.postImageURL = postImageURL
        
        }
    
    
    
    
    
    init?(username:String?,content:String?,userimageURL:String?,postImageURL:String?,email:String?) {
        
        self.username = username
        self.content = content
        self.userImageURL = userimageURL
        self.postImageURL = postImageURL
        
        self.email = email
    }
    
    
    init?(username:String?,content:String?) {
        
        
        self.username = username
        self.content = content
        
    }
    
    
    //This is from what comes back for getResturantById cuz we need to take the json files that come from the firebase and make them var's again
    
    init(json:Dictionary<String,String>){
        
        //*/** we need to fix this also1/** adding userIamgeURL And post imageurl
        
        content = json["content"]
        username   = json["username"]!
        userImageURL = json["userImageURL"]
        postImageURL = json["postImageURL"]
        email = json["email"]
        
    }
    
    
    
    //before sending the details we need to put them in json files and send upload the json file of each resturant to FB
    func toFirebase() -> Dictionary<String,String> {
        var json = Dictionary<String,String>()
        json["content"] = content
        json["username"] = username
        json["userImageURL"] = userImageURL
        json["postImageURL"] = postImageURL
        json["email"] = email
       
        return json
    }
    
    
    
 
}


