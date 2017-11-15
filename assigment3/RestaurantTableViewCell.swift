//
//  StudentTableViewCell.swift
//  assigment3
//
//  Created by admin on 10/12/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    

    @IBOutlet weak var fnameLabel: UILabel!
    @IBOutlet weak var lnameLabel: UILabel!
    
    @IBOutlet weak var idLabelText: UILabel!
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
  //  @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
