//
//  UserManager.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/16.
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
    
    func fetchUsers() {
        let query = PFUser.query
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                self.tweets = []
                for object in objects! {
                    let username = object["username"] as! String
                    let age = object["age"] as! Int
//                    let gender = object["gender"]
                    let image = object["image"] as! String
                    let password = object["password"] as! String
                    let email = object["emaiol"] as! String
                    let text = object["text"] as! String
//                    let user = User(usename: )
//                    let user = User.init()

//                    self.users.append(user)
//                    self.tweets.append(tweet)
                }
            }
        }
    }

}
