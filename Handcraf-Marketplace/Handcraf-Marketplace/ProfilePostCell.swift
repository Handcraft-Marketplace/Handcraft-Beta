//
//  ProfilePostCell.swift
//  Handcraf-Marketplace
//
//  Created by Cyrus Simons on 12/9/20.
//

import UIKit

class ProfilePostCell: UITableViewCell {
    
    @IBOutlet weak var postimg: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postPrice: UILabel!
    @IBOutlet weak var postUser: UILabel!
    @IBOutlet weak var postDesc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
