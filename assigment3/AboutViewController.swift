//
//  AboutViewController.swift
//  assigment3
//
//  Created by admin on 21/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit


class AboutViewController: UIViewController {

    
    @IBOutlet var textLabel: UILabel!
    
    var welcome = String()
    
    
    @IBOutlet var userImageView: UIImageView!
    
    var userimage:UIImage?
    
    var enterphotoURL:String? // This is coming from the Prepare function at "LoginViewController"
    var style44:String? //this is the email of the user ready to be saved at local if the userimage == nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        
        //We get the enterPhotoURL from prepare function at LoginViewController
        //1.if get nil from userimage so there is no image at local so we go FB and save it for local for next time
        if userimage == nil {
            PostFireBase.instance.getImageFromFirebase(url: self.enterphotoURL!, callback: { (image) in
                
               self.userImageView.image = image
                
                 Model.instance.saveImageToFileLocal(image: image!, name: self.style44!)
                
            })
            
            
           
            
        }
        
        textLabel.text = welcome
        
        
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2
        userImageView.clipsToBounds = true
        
        userImageView.image = userimage
        
 
        

        // Do any additional setup after loading the view.
    }
    
    


    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
