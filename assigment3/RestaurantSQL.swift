//
//  Student+SQL.swift
//  assigment3
//
//  Created by admin on 19/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

//for localdb

extension Restaurant{
    
    
    static let ST_TABLE = "Restaurants"

    static let ST_ID = "ST_ID"
    static let ST_FNAME = "FNAME"
    static let ST_lNAME = "lNAME"
    static let ST_phone = "phone"
    static let ST_IMAGE = "imageID" //we put there the id

    static let ST_IMAGE_URL = "IMAGE_URL"
    
    
    static func createTable(database:OpaquePointer?)->Bool{
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS " + ST_TABLE + " ( " + ST_ID + " TEXT PRIMARY KEY, "
            + ST_FNAME + " TEXT, "
            + ST_lNAME + " TEXT," + ST_phone + " TEXT, "  + ST_IMAGE + " TEXT, " + ST_IMAGE_URL + " TEXT  )"  , nil, nil, &errormsg);
        
        if(res != 0){
            print("error creating table");
            return false
        }
        
        return true
    }
    
    func addRestaurant(database:OpaquePointer?){
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO " + Restaurant.ST_TABLE
            
            + "(" + Restaurant.ST_ID + ","
            + Restaurant.ST_FNAME + ","
            + Restaurant.ST_lNAME + ","
            + Restaurant.ST_phone + ","
            + Restaurant.ST_IMAGE + ","
            + Restaurant.ST_IMAGE_URL + ") VALUES (?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            
            let id = self.id?.cString(using: .utf8)
            let fname = self.fname.cString(using: .utf8)
            let lname = self.lname.cString(using: .utf8)
            let phone = self.phone?.cString(using: .utf8)
            
            
            
            var imageID = self.id?.cString(using: .utf8)
            
            if self.imageID != nil {
                imageID = self.imageID!.cString(using: .utf8)
            }
            
            
//            if self.imageURL == nil {
//                
//                
//            }
            
            var IMAGE_URL = self.imageURL?.cString(using: .utf8)

            
            

            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, fname,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, lname,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, phone,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, imageID,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, IMAGE_URL,-1,nil);

            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    static func getAllRestaurants(database:OpaquePointer?)->[Restaurant]{
        var restaurants = [Restaurant]()
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from Restaurants;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                
                let stId =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,0))
                
                let fname =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,1))
                
                let lname =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,2))

                let phone =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,3))
                
                let imageID =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,4))

                let IMAGE_URL =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,5))
                
                print("read from filter st: \(stId) \(fname) \(lname) \(phone) \(imageID) \(IMAGE_URL)")
                
                
//                if (imageUrl != nil && imageUrl == ""){
//                    imageUrl = nil
//                }

                let restaurant = Restaurant(fname: fname! , lname: lname! , id: stId , phone: phone!,imageID: imageID, imageURL: IMAGE_URL)
                
                restaurants.insert(restaurant!, at: 0)
                //restaurants.append(restaurant!)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        
        return restaurants
    }
    
}
