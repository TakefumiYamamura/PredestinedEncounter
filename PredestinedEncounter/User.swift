//
//  User.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/13.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit
import Parse

enum UserGender: Int {
    case Man = 0
    case Woman = 1
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
}
