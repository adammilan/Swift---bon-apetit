//
//  StudentDetailsViewController.swift
//  assigment3
//
//  Created by admin on 12/12/2016.
//  Copyright © 2016 admin. All rights reserved.
//



import UIKit

class RestaurantDetailsViewController: UIViewController {

    var fnameToDisplay:String?
    var lnameToDisplay:String?
    var idToDisplay:String?
    var phoneToDisplay:String?
    var imageToDisplay:UIImage?
    
    @IBOutlet weak var fnameLabel: UILabel!

    @IBOutlet weak var lnameLabel: UILabel!
    
    
    @IBOutlet weak var idLabel: UILabel!
    
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var restImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fnameLabel.text = fnameToDisplay
        lnameLabel.text = lnameToDisplay
        

        
        idLabel.text = String(describing: idToDisplay!)
        phoneLabel.text = String(describing: phoneToDisplay)
        
        restImage.image = imageToDisplay
        
        
        
//        print(fnameToDisplay)
//        if fnameToDisplay != nil {
//            self.fnameLabel.text = fnameToDisplay
//        }


}
    
}
