//
//  ProfileViewController.swift
//  Handcraf-Marketplace
//
//  Created by Bocar Sock on 11/13/20.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var styleField: UITextField!
    @IBOutlet weak var savedLabel: UILabel!
    
    var currentUser = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedLabel.text = ""

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        savedLabel.text = ""
        
    }
    
    @IBAction func onChangeButton(_ sender: Any) {
        let updatedUser = PFObject(className: "Users")
        
        let query = PFQuery(className:"Users")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current()!)
        
        query.findObjectsInBackground { (users, error) in
            if users !=  nil{
                for i in users!{
                    try! i.delete()
                }
                }
            }
        
        updatedUser["firstName"] = firstNameField.text!
        updatedUser["lastName"] = lastNameField.text!
        updatedUser["phoneNumber"] = phoneNumberField.text!
        updatedUser["style"] = styleField.text!
        updatedUser["author"] = PFUser.current()!
        
        let imageData = profileImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        updatedUser["pimage"] = file
        
        updatedUser.saveInBackground { (success, error) in
            if success{
                self.firstNameField.text = ""
                self.lastNameField.text = ""
                self.phoneNumberField.text = ""
                self.styleField.text = ""
                self.savedLabel.text = "Updated!"
                self.profileImage.image = nil

                print("Saved!")
            } else{
                print("Error!")
            }
        }
        
    }
    
    @IBAction func onProfilePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
