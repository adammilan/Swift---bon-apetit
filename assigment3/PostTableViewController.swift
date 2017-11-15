//
//  PostTableViewController.swift
//  assigment3
//
//  Created by admin on 22/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewController: UITableViewController {

    
    
    
    var posts = [Post]()
    
    
    //we need to put it outside of the viewDidLoad cuz we need to use it!
    //viewDidLoad happend with the ViewController has been called.
    
    
    
    
    @IBAction func Back(_ sender: AnyObject) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let postRef = FIRDatabase.database().reference().child("posts")
        postRef.observe(.value, with: { snapshot in
            print(snapshot.value)
            
            
            self.posts.removeAll()
            
            PostFireBase.instance.getAllPosts { (post) in
                
                for po in post {
                    

                    print ("email: \(po.email)")
                    
                   self.posts.insert(po, at: 0) //enter them from above
                    
                    //self.posts.append(po) // this enter them from the end
          
                    
                }
                self.tableView.reloadData()
            }
            
            
            
            
        })
        
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print (posts.count)
        return posts.count
    }
    
    
  
    //How each cell functional/display
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
       
        
        let cellIndentifier = "PostTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as! PostTableViewCell
        
        
    
        
       // let stu = posts[indexPath.row]
        
//        stu.username = "Test"
//        stu.content = "Bla bla bla....."
//        stu.postImage = #imageLiteral(resourceName: "defaultPhoto")
//        
        cell.usernameLabel.text = posts[indexPath.row].username
        cell.contentTextField.text = posts[indexPath.row].content
        
        
        
        
        
        var localphoto = Model.instance.getImageFromFileLocal(name: posts[indexPath.row].email! + (".jpg"))  //this is the profile picture (local) 
        
        if (localphoto == nil){ //we cheak first if we have it on local
        
        PostFireBase.instance.getImageFromFirebase(url: posts[indexPath.row].userImageURL!, callback: { (userImage) in //(this is for the userImage)
 
             cell.usernamePic.image = userImage
            
            
            //TODO:
            //1.if we dont have the picture local we go to FB download the userImagepicture and then we storage it on locall so next time we dont need to go fb again
             Model.instance.saveImageToFileLocal(image: userImage!, name: (self.posts[indexPath.row].email! + (".jpg")))
      
        })
        }else{
            
                cell.usernamePic.image = localphoto
        }
        
        
        PostFireBase.instance.getImageFromFirebase(url: posts[indexPath.row].postImageURL!, callback: { (postImage) in //(this is for the postiamge)
            
            
           cell.userPostImage.image = postImage
            
            
            
        })

        
       // cell.userPostImage.image = stu.postImage
       // cell.usernamePic.image = stu.userImage
        
        
        
        // Configure the cell...
        
        
       

        return cell
    }
    
    
    
    
    var selectedIndex:Int?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print ("didSelectRowAt \(indexPath)")
        selectedIndex = indexPath.row
        
        print(selectedIndex)
    
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        
//        print(selectedIndex)
//        
// 
//        
//    }
    
    @IBAction func unwindToPostsList (sender: UIStoryboardSegue)
    {
        
        // if = True all the sensetise is actually true , we add let student = source.. as if its nill so dont go in
        if let sourceViewController = sender.source as? PostViewController,let post = sourceViewController.post {
            
       
            //Add a new Student
            let newIndexPath = NSIndexPath(row: posts.count, section: 0)
            
            posts.append(post) //adding the post to the array
            //posts.insert(post, at: 0)
            
            //this is for the saving from the Firebase database
            //Model.instance.addRestaurant(st: restaurant)
            
            tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
        
        
        
        
        }
    }

   


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
