//
//  UserManager.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/24.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class UserManager: NSObject {
    static let sharedInstance = UserManager()
    var users: [User] = []
    var swipeUsers: [User] = []
    var matchingUsers: [User] = []
    func fetchUsers() {
        let query = PFUser.query()
        query!.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                self.users = []
                for object in objects! {
                    object
                    let username = object["username"] as! String
                    let age = object["age"] as! Int
                    let gender = object["gender"] as! String
                    let image = object["image"] as! String
                    let password = "dammypass"
                    let email = object["email"] as! String
                    let user = User(username: username, age: age, gender: UserGender(rawValue: gender)!, image: image, password: password, email: email)
                    print(user)
                    self.users.append(user)
                }
            }
        }
    }
    
    func fetchSwipeUsers(callback: () -> Void){
        let query = PFUser.query()
        query!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                self.users = []
                for object in objects! {
                    object
                    let username = object["username"] as! String
                    let age = object["age"] as! Int
                    let gender = object["gender"] as! String
                    let image = object["image"] as! String
                    let password = "dammypass"
                    let email = object["email"] as! String
                    let user = User(username: username, age: age, gender: UserGender(rawValue: gender)!, image: image, password: password, email: email)
                    print(user)
                    self.swipeUsers.append(user)
                }
                callback()
            }
        }
    }
}
