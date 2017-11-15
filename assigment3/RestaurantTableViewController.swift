//
//  StudentTableViewController.swift
//  assigment3
//
//  Created by admin on 10/12/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import Firebase

class RestaurantTableViewController: UITableViewController {

    
    //MARK: Properties
    
    var restaurants = [Restaurant]() //arry of student empty array of students by putting "var" we make the arry Mutable which means we can add items to it after we initalize it
    
    override func viewDidLoad() {
        super.viewDidLoad()

            
        //Use the edit button item provided by the table view controlelr
        navigationItem.leftBarButtonItem = editButtonItem

       // self.view.backgroundColor = UIColor.darkGray
   

        
        let resturantRef = FIRDatabase.database().reference().child("resturants")
        resturantRef.observe(.value, with: { snapshot in
        
            self.restaurants.removeAll()
            print (snapshot.childrenCount)
            
            //getAllResturant from fireBase
            
            RestaurantFirebase.instance.getAllRestaurants(callback: { (restauranta) in
                
                
                
                for po in restauranta{
                    
                      self.restaurants.insert(po, at: 0)
                   // self.restaurants.append(po)
                    //save the details to the firebase as json
                    let Restaurant7 = Restaurant(fname: po.fname, lname: po.lname, id: po.id , phone: po.phone! ,imageURL: po.imageURL)
                    Model.instance.addRestaurant(st: Restaurant7!)
                    
              
                }
                
                self.tableView.reloadData()
             
            })
            
            })
    
        
        
        //db local
        
            Model.instance.getAllRestaurants(callback: {  (resSQL) in
            
            var newRestaurants = [Restaurant]()
            
            if resSQL.count != 0 {
            
            
            for stu in resSQL {
            print("restaurants name: \(stu.fname)")
            
            var style = stu.imageID! +  (".jpg") // for each line in the sqlite Database
            
            
            print("style: \(style)")
           // var photo = Model.instance.getImageFromFileLocal(name: style)
            
            
            
            let Restaurant7 = Restaurant(fname: stu.fname, lname: stu.lname, id: stu.id , phone: stu.phone!, imageURL : stu.imageURL)
                
                
            newRestaurants.insert(Restaurant7!, at: 0)
            //newRestaurants.append(Restaurant7!)
            
           
            }
            
            
            self.restaurants = newRestaurants
            self.tableView.reloadData()
            
                }
     
        })
    
   
                //self.tableView.reloadData()
            //resturantExist = 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
 



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(restaurants.count)
        return restaurants.count
    
    }

    //how each Cell functional/display
    
    //    //each time Indexpath in being count to 0 and then 1 and the 2..  beacuse the function ovedet for each cell like a counter and then we took the object from the student and we put in the cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cellIndentifier = "RestaurantTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as! RestaurantTableViewCell

     
       // let stu = restaurants[indexPath.row]
        
        
        // Configure the cell...
        
        cell.fnameLabel.text = restaurants[indexPath.row].fname
        cell.lnameLabel.text = restaurants[indexPath.row].lname
        //cell.restuImage.image = stu.image

        //print(stu.image)
        
        
        
        //we first looking for in the local
        var localphotoRest = Model.instance.getImageFromFileLocal(name: restaurants[indexPath.row].id! + (".jpg"))  //this is the profile picture restruant (local)
        
        if (localphotoRest == nil){ //if we dont have it on local then we go fb and save it after for next time
            
            PostFireBase.instance.getImageFromFirebase(url: restaurants[indexPath.row].imageURL!, callback: { (restImage) in //(this is for the userImage)
                
               
                cell.photoImageView.image = restImage
                //this is for the image to be saved when we pressed the resturant at "prepare" function down all the details will be also the image of the resturant
                self.restaurants[indexPath.row].image = restImage
                
                //TODO:
                //1.if we dont have the picture local we go to FB download the userImagepicture and then we storage it on locall so next time we dont need to go fb again
                Model.instance.saveImageToFileLocal(image: restImage!, name: (self.restaurants[indexPath.row].id! + (".jpg")))
                
            })
        }else{
            
                //cell.photoImageView.image = stu.image
            
           cell.photoImageView.image = localphotoRest
            //this is for the image to be saved when we pressed the restu at "prepare" function down all the details will be
            self.restaurants[indexPath.row].image = localphotoRest

            
        }

        
    
      //  cell.imageView?.image = stu.image
      //  cell.restuImage.image = stu.image
       
        return cell
    }
    

    
    //Title Header in Section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "First name " + "            " + "  Last name"
        
    
    }
    
    
    
    @IBAction func unwindToStudentsList (sender: UIStoryboardSegue)
    {
        
        
        
        // if = True all the sensetise is actually true , we add let student = source.. as if its nill so dont go in
        if let sourceViewController = sender.source as? RestaurantViewController,let restaurant = sourceViewController.restaurant{
            
            
            //Add a new Student
            let newIndexPath = NSIndexPath(row: restaurants.count, section: 0)
            
            restaurants.append(restaurant)
            
            //this is for the saving from the Firebase database
            Model.instance.addRestaurant(st: restaurant)
            
            tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
           
        }
        
       
            
            
        }
    
    
    var selectedIndex:Int?
    
    
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("didSelectRowAt \(indexPath)")
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "presentRestaurantDetails", sender: self)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(selectedIndex)

        
        if segue.identifier == "presentRestaurantDetails" {
        
        //Preparing for the the destination for the segue
        let RestaurantDetails :RestaurantDetailsViewController = segue.destination as! RestaurantDetailsViewController
        
        //Sending the data
        RestaurantDetails.fnameToDisplay = restaurants[selectedIndex!].fname
        RestaurantDetails.lnameToDisplay = restaurants[selectedIndex!].lname
        RestaurantDetails.idToDisplay = restaurants[selectedIndex!].id
        RestaurantDetails.phoneToDisplay = restaurants[selectedIndex!].phone
        RestaurantDetails.imageToDisplay = restaurants[selectedIndex!].image

        
    
    }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            restaurants.remove(at: indexPath.row) // this line delete from the arry
            tableView.deleteRows(at: [indexPath], with: .fade) // this line delete the row
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



}
