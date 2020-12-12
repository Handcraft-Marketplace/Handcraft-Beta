//
//  CartViewController.swift
//  Handcraf-Marketplace
//
//  Created by Bocar Sock on 11/14/20.
//

import UIKit
import Parse
import AlamofireImage

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [PFObject]()
    let cartRefresh = UIRefreshControl()
    var posts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.cartRefresh.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        self.tableView.refreshControl = cartRefresh
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "CartItems")
        query.includeKey("cartOwner")
        query.whereKey("cartOwner", equalTo: PFUser.current()!)
        
        query.findObjectsInBackground { (items, error) in
            if error == nil && items !=  nil{
                self.items = items!
            }
        }
        populatePosts()
        self.tableView.reloadData()
        self.cartRefresh.endRefreshing()

    }
    
    func populatePosts() {
        for i in items {
            let postQuery = PFQuery(className: "Posts")
            postQuery.includeKey("objectId")
            let stuff = i["postObj"] as! PFObject
            postQuery.whereKey("objectId", equalTo: stuff.objectId!)
            
            postQuery.getFirstObjectInBackground { (item, error) in
                if error == nil && item !=  nil {
                    if !self.posts.contains(item!) {
                        self.posts.append(item!)
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CartPostCell") as! PostCell
                 
        let post = posts[indexPath.row]
        //let user = post["author"] as! PFUser
        
        //cell.userLabel.text = user.username
        cell.titleLabel.text = (post["title"] as? String) ?? ""
        cell.priceLabel.text = "$\((post["price"] as? String) ?? "0")"
        cell.descLabel.text = post["description"] as? String
         
        let imageFile = post["image"] as! PFFileObject
        
         
        let imgurl = URL(string: imageFile.url!)!
        
        cell.photoView.af.setImage(withURL: imgurl)

        return cell
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
