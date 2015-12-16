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

enum UserGender: Int {
    case Man, Woman
}

class User: NSObject {
    var name: String
    var age: String
    var gender: UserGender
    var image: PFFile

    init(name: String, age: String, gender: UserGender, image: PFFile){
        self.name = name
        self.age = age
        self.gender = gender
        self.image = image
    }
    
    func save() {
        let usersObject = PFObject(className: "User")
        usersObject["name"] = name
        usersObject["age"] = age
        usersObject["gender"] = gender.rawValue
        usersObject["image"] = image
    }
}
