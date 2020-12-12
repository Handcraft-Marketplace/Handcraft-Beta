//
//  FeedViewController.swift
//  Handcraf-Marketplace
//
//  Created by Bocar Sock on 11/6/20.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    var cartQuery = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.myRefreshControl.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts !=  nil{
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
                
        let post = posts[posts.count - (indexPath.row + 1)]
        let user = post["author"] as! PFUser
        
        cell.userLabel.text = user.username
        cell.titleLabel.text = post["title"] as? String
        cell.priceLabel.text = "$\((post["price"] as? String) ?? "0")"
        cell.descLabel.text = post["description"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        
        let imgurl = URL(string: imageFile.url!)!

        cell.photoView.af.setImage(withURL: imgurl)
        
        cell.actionBlock = {
            let cartItem = PFObject(className: "CartItems")
            var quantity = 1
            
            let query1 = PFQuery(className: "CartItems")
            query1.includeKey("cartOwner")
            query1.whereKey("cartOwner", equalTo: PFUser.current()!)
             
            query1.findObjectsInBackground { (items, error) in
                if error == nil && items !=  nil{
                    self.cartQuery = items!
                    for i in items! {
                        let stuff = i["postObj"] as! PFObject
                        if stuff.objectId == post.objectId!{
                            try! i.delete()
                        }
                    }
                }
            }
            
            for i in self.cartQuery {
                let stuff = i["postObj"] as! PFObject
                if stuff.objectId == post.objectId! {
                    quantity = i["quantity"] as! Int
                    quantity += 1
                    //try! i.delete()
                    //i["quantity"] = quantity
                } else { quantity = 1 }
            }
            
            cartItem["quantity"] = quantity
            cartItem["postObj"] = post
            cartItem["cartOwner"] = PFUser.current()
             
            cartItem.saveInBackground { (success, error) in
                if success{
                    print("Saved!")
                } else{
                    print("Error!")
                }
            }
        }
        
        return cell
    }
    
    

    
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window!.windowScene!.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let id = segue.identifier!
        
        if id == "PostDetailsViewControllerSegue"{
            //Find the selected post
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let post = posts[posts.count - (indexPath.row + 1)]
            
            //Pass the selected movie to the details view controller
            let detailsViewController = segue.destination as! PostDetailsViewController
            
            detailsViewController.post = post
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }

    }
    

}
