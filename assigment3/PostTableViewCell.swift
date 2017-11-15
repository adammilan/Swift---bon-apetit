//
//  PostTableViewCell.swift
//  assigment3
//
//  Created by admin on 22/01/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    @IBOutlet weak var usernamePic: UIImageView!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var userPostImage: UIImageView!
    
    
    @IBOutlet weak var contentTextField: UITextView!
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        usernamePic.layer.cornerRadius = usernamePic.frame.size.width/2
        usernamePic.clipsToBounds = true
       
        
        
        // Configure the view for the selected state
    }

}
