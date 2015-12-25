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
    var objectId: String
    var username: String
    var age: Int
    var gender: String
    var image: String
    var password: String
    var email: String

    init(objectId: String, username: String, age: Int, gender: UserGender, image: String, password: String, email: String){
        self.objectId = objectId
        self.username = username
        self.age = age
        self.gender = gender.rawValue
        self.image = image
        self.password = password
        self.email = email
    }
    
    func signUp(callback: (message: String?) -> Void) {
        let user = PFUser()
        user.objectId = objectId
        user.username = username
        user.password = password
        user.email = email
        user["image"] = image
        user["gender"] = gender
        user["age"] = age
        user.signUpInBackgroundWithBlock { (success, error) in
            if let unwrappedError = error {
                print("登録済み")
            } else {
                print("サインアップ成功")
            }
        }
    }
    
    func login(callback: (message: String?) -> Void) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) in
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
