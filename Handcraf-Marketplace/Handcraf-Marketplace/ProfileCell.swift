//
//  ProfileCell.swift
//  Handcraf-Marketplace
//
//  Created by Cyrus Simons on 12/8/20.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var profImg: UIImageView!
    @IBOutlet weak var uNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
