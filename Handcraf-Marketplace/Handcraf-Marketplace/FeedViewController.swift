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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.descriptionLabel.text = post["description"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
        
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
            let post = posts[indexPath.row]
        
            //Pass the selected movie to the details view controller
            let detailsViewController = segue.destination as! PostDetailsViewController
            
            detailsViewController.post = post
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        /*/Find the selected post
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.row]
    
        //Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! PostDetailsViewController
        detailsViewController.post = post
        
        tableView.deselectRow(at: indexPath, animated: true)
        */
    }
    

}
