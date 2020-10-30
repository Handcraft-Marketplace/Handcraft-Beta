Handcraft-Beta App Design Project - README
===

###### Collaborators: `Amena Foshanji, Bocar Sock, Cyrus Simons, Erkin Islam`

###### Last Edit by: `Cyrus Simons`

**Brainstorm README gist:** [gist link](https://gist.github.com/cjsproject/f28f1030a4f81257d9342e887fd2a866)

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

<img src="https://i.ibb.co/rpBMgSr/Marketplace-Wireframe.jpg" width=612>


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
