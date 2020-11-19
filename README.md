Handcraft-Beta App Design Project - README
===

###### Collaborators: `Amena Foshanji, Bocar Sock, Cyrus Simons, Erkin Islam`

###### Last Edit by: `Cyrus Simons`

###### Brainstorm README gist: [gist link](https://gist.github.com/cjsproject/f28f1030a4f81257d9342e887fd2a866)

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Marketplace style iOS app that allows anyone to buy, sell, post and like hand made objects.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Public online marketplace. 
- **Mobile:** App.
- **Story:** Allows users to post, sell and buy their products.
- **Market:** Anyone that makes and buys arts & crafts would enjoy and/or benefit from this app.
- **Habit:** Users can sell and buy products throughout the day, 24/7 market feature. Features like “Rating” encourage more candid posting as well. Users can explore endless products in any category imaginable whenever they want.
- **Scope:** HandCraft Marketplace is originally designed to help local artists sell their products to their fellow art lovers. However, it is intended to grow and serve worldwide.


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Signup/Register
* Login
* Post a product
* Buy a product
* Search for product


**Optional Nice-to-have Stories**

* Like/Unlike a product
* Comment on a product
* Rate a product
* categorical listings
* search view

### 2. Screen Archetypes

* Signup/Login
   * User can Sign-up using their own credentials or using some form of API (google, pinterest,etc)
   * simple login screen (phone # & password)
   * signup only needs username, phone # & pass (optional email for verification)
* Home Screen
   * user can scroll through the homepage with all of the seller's listings available.
   * can click individual posts for more details
   * ability to favorite an item from the homescreen
   * cell contains image of listing, its name/title and a brief desc along with the like/save button.
* User Profile
    * Has username on display
    * Has each user's favorite listings visible and clickable.
* Listings
    * When clicking on listings, will present modally new window with full details, images etc.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home (listings)
* Account Settings
* Profile (image, likes, etc.)

**Flow Navigation** (Screen to Screen)

* Login/Signup view
   * Homepage
* HomePage view
   * Home (listings)
   * Account Settings
   * Profile
   * List an Item
   * Listing Details
   * logout -> (login/signup)
* List an Item view
    * camera roll
    * back -> HomePage
* Listing Details view
    * Seller -> (User Profile)
    * back -> Homepage


## Wireframes

<img src="http://g.recordit.co/5Qb2dGPMpD.gif" width=612>


### [BONUS] Digital Wireframes & Mockups

<img src="http://g.recordit.co/0E162l1qFe.gif" width=612>


### [BONUS] Interactive Prototype

## Schema 

### Models

**user**
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| userid        | String   | unique id for the user (default field) |
| phone         | String   | user phone number |
| username      | String   | user custom name (may be unique?) |
| profimg       | string/ur| user custom profile image |
| password      | String   | secure storage of password for user |
| age           | Number   | age of user |
| first         | String   | firstname of user |
| last          | String   | lastname of user |
| style         | String   | general interest/ categories/ selling preference |
| created       | DateTime | date when user signs up |


**Listing**
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| postid        | String   | unique id for the post (default field) |
| owner         | String   | userid reference (default field) |
| title         | String   | Listing title |
| price         | Number   | price of item |
| category      | string/ur| type of item |
| desc          | String   | describes listing |
| created       | DateTime | date when post was created |

**App Settings**
*tentative*

### Networking
 - Home Screen
  -(Read/GET) login
```swift
  let uName = usernameField.text!
  let password = passwordField.text!

  PFUser.logInWithUsername(inBackground: uName, password: password) { (user, error) in
      if user != nil{
          self.performSegue(withIdentifier: "loginSegue", sender: nil)
      } else{
          let error = error
          let errorString = error?.localizedDescription
          // Show the errorString somewhere and let the user try again.
          print("\(String(describing: errorString))")
      }
  }
  ```
  
  -(Create/POST) signup
 - Home Feed Screen
    - (Read/GET) Query all posts where user is author
    ```swift
     let query = PFQuery(className:"Listing")
     query.whereKey("owner", equalTo: currentUser)
     query.order(byDescending: "created")
     query.findObjectsInBackground { (listigs: [PFObject]?, error: Error?) in
        if let error = error { 
           print(error.localizedDescription)
        } else if let listings = listings {
           print("Successfully retrieved \(listings.count) posts.")
       // TODO: Do something with posts...
        }
     }
     ```

    - (Create/POST) Create a new like on a post
    - (Delete) Delete existing like
    - (Create/POST) Create a new purchase
    - (Delete) cancel purchase
 - Create Listing Screen
    - (Create/POST) Create a new Listing object
 - Profile Screen
    - (Read/GET) Query logged in user object
    - (Update/PUT) Update user profile image
    - (Delete) Remove favorites
    
#### [OPTIONAL:] Existing API Endpoints
##### Back4App
- Base URL - [https://parseapi.back4app.com](https://dashboard.back4app.com/apps)

   HTTP Verb | function | Description
   ----------|----------|------------
    `GET`    | PFUser.loginwithusername()    | Logs user in
    `UPDATE` | PFUser.logout()   | Logs user out
    `POST`   | PFObject(PFUser).saveinbackground  | creates new user object
    `GET`    | PFQuery(obj).getobjects | get all objects of type 'obj'
    `POST`   | PFObject(obj).saveinbackground | save new object of type 'obj'
    
    
#### .gif Progress

<img src="https://i.imgur.com/dKLwy88.gif" width=250>
