//
//  PostDetailsViewController.swift
//  Handcraf-Marketplace
//
//  Created by Bocar Sock on 11/16/20.
//

import UIKit
import Parse
import AlamofireImage

class PostDetailsViewController: UIViewController {
    
    @IBOutlet weak var postDetailsImage: UIImageView!
    @IBOutlet weak var postDetailsTitleLabel: UILabel!
    @IBOutlet weak var postDetailsPriceLabel: UILabel!
    @IBOutlet weak var postDetailsCategoryLabel: UILabel!
    @IBOutlet weak var postDetailsDescriptionLabel: UILabel!

    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        
        postDetailsTitleLabel.text = post["title"] as? String
        postDetailsTitleLabel.sizeToFit()
        postDetailsPriceLabel.text = post["price"] as? String
        postDetailsPriceLabel.sizeToFit()
        postDetailsCategoryLabel.text = post["category"] as? String
        postDetailsCategoryLabel.sizeToFit()
        postDetailsDescriptionLabel.text = post["description"] as? String
        postDetailsDescriptionLabel.sizeToFit()
        
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        postDetailsImage.af.setImage(withURL: url)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
