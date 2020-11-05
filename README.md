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


**Posts**
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
 - Home Feed Screen
    - (Read/GET) Query all posts where user is author
       ```swift
       let query = PFQuery(className:"Post")
       query.whereKey("author", equalTo: currentUser)
       query.order(byDescending: "createdAt")
       query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
          if let error = error { 
             print(error.localizedDescription)
          } else if let posts = posts {
             print("Successfully retrieved \(posts.count) posts.")
         // TODO: Do something with posts...
          }
       }
       ```
    - (Create/POST) Create a new like on a post
    - (Delete) Delete existing like
    - (Create/POST) Create a new comment on a post
    - (Delete) Delete existing comment
 - Create Post Screen
    - (Create/POST) Create a new post object
 - Profile Screen
    - (Read/GET) Query logged in user object
    - (Update/PUT) Update user profile image


- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
