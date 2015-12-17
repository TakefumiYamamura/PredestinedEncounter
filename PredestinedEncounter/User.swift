//
//  User.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/13.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

enum UserGender: String {
    case male, female
}

class User: NSObject {
    var username: String
    var age: Int
    var gender: String
    var image: PFFile
    var password: String
    var email: String

    init(username: String, age: Int, gender: UserGender, image: PFFile, password: String, email: String){
        self.username = username
        self.age = age
        self.gender = gender.rawValue
        self.image = image
        self.password = password
        self.email = email
    }
    
    func signUp(callback: (message: String?) -> Void) {
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        user["image"] = image
        user["gender"] = gender
        user["age"] = age
        user.signUpInBackgroundWithBlock { (success, error) in
            callback(message: error?.userInfo["error"] as? String)
        }
    }

    func save() {
        let usersObject = PFObject(className: "User")
        usersObject["username"] = username
        usersObject["age"] = age
        usersObject["gender"] = gender
        usersObject["image"] = image
    }
}
