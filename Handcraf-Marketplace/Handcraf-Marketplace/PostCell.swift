//
//  PostCell.swift
//  Handcraf-Marketplace
//
//  Created by Bocar Sock on 11/14/20.
//

import UIKit
import Parse
import AlamofireImage

class PostCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var actionBlock: (() -> Void)?
    //var actionBlock: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func CartButton(_ sender: Any) {
        actionBlock?()
    }
    
}
