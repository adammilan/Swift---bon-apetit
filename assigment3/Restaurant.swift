//
//  Student.swift
//  assigment3
//
//  Created by admin on 10/12/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class Restaurant{

    //Properites:
var fname: String
var lname: String
var id: String? //exclamtion mark mean's that id is a type of int and it might be nil
var phone:String?
    
    var image: UIImage?
    
    var imageID: String?
    
    var imageURL:String?

    
  // var imageURL: String? //for the firebase we save the image url we put there the ID of the restuarant
    

    //Initlization stored properties
    init?(fname: String , lname: String, id: String?, phone: String?, imageID:String? = nil , imageURL:String?){
        self.fname = fname
        self.lname = lname
        self.id = id
    
        self.imageID = id
        
        self.phone = phone
    
        self.imageURL = imageURL
        
        //Initlization should fail if there is no name or id correct
        if fname.isEmpty || lname.isEmpty {
        
            return nil
        }
        
    }
    
    
    
    init?(fname:String, lname:String, id:String?,phone:String, imageURL:String?){
        self.fname = fname
        self.lname = lname
        self.id = id
        self.phone = phone
        self.imageURL = imageURL
        
    }
    
    
    
    init?(fname:String, lname:String, id:String?,phone:String,  image:UIImage , imageURL:String?){
        self.fname = fname
        self.lname = lname
        self.id = id
        self.phone = phone
        self.image = image
        self.imageURL = imageURL
    }
    
    
    //This is from what comes back from FB for getResturantById or any other function cuz we need to take the json files that come from the firebase and make them var's again
    
    init(json:Dictionary<String,String>){
        
        
        fname = (json["fname"])!
        id = json["id"]
        lname = json["lname"]!
        phone = json["phone"]
        imageURL = json["imageURL"]
        
        if let im = json["imageURL"]{
            imageID = im
        }
    }
    


    //before sending the details we need to put them in json files and send upload the json file of each resturant to FB
    func toFirebase() -> Dictionary<String,String> {
        var json = Dictionary<String,String>()
        json["fname"] = fname
        json["lname"] = lname
        json["id"] = id
        json["phone"] = phone
        json["imageURL"] = imageURL
        
        if (imageID != nil){
            json["imageURL"] = imageID!
        }
        return json
    }
    
    

}




