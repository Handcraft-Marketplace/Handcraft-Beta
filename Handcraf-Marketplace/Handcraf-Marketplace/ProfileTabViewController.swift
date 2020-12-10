//
//  ProfileTabViewController.swift
//  Handcraf-Marketplace
//
//  Created by Cyrus Simons on 12/8/20.
//

import UIKit
import Parse
import AlamofireImage

class ProfileTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    var currentUser = PFUser.current()!
    var userInfo = PFObject(className: "Users")
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
        let query1 = PFQuery(className: "Users")
        query1.includeKey("author")
        query1.whereKey("author", equalTo: PFUser.current()!)
        query1.getFirstObjectInBackground { (user, error) in
            if error == nil && user !=  nil{
                self.userInfo = user!
            }
        }
        //userInfo = try! query1.getFirstObject()
        /*query1.findObjectsInBackground { (user, error) in
            if error == nil && user !=  nil{
                for i in user!{
                    self.userInfo = i
                }
            }
        }*/
        
        
        let query2 = PFQuery(className: "Posts")
        query2.includeKey("author")
        query2.whereKey("author", equalTo: currentUser)
        
        query2.findObjectsInBackground { (posts, error) in
            if posts !=  nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
            cell.uNameLabel.text = currentUser.username
            cell.nameLabel.text = userInfo["firstName"] as? String
            cell.styleLabel.text = userInfo["style"] as? String
            cell.profImg.image = userInfo["pimage"] as? UIImage
            
            let fileobj = userInfo["pimage"] as? PFFileObject
            let url = URL(string: fileobj?.url! ?? "https://static.thenounproject.com/png/125115-200.png")
            cell.profImg.af.setImage(withURL: url!)
            
            /*
            let fileobj = userInfo["pimage"] as! PFFileObject
            let url = URL(string: fileobj.url!)
            cell.profImg.af.setImage(withURL: url!)
            */
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfPostCell") as! ProfilePostCell

            let post = posts[posts.count - (indexPath.row)]
            
            cell.postUser.text = currentUser.username
            cell.postTitle.text = post["title"] as? String
            cell.postPrice.text = "$\((post["price"] as? String) ?? "0")"
            cell.postDesc.text = post["description"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            
            let imgurl = URL(string: imageFile.url!)!

            cell.postimg.af.setImage(withURL: imgurl)
            
            
            return cell
        }
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
