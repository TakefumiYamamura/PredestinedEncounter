//
//  User.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/13.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit

enum UserSex: Int {
    case Man = 0
    case Woman = 1
}

class User: NSObject {
    var name: String
    var sex: String
//    var age: UserSex
//    init(name: String, sex: String, age: UserSex){
    init(name: String, sex: String){
        self.name = name
        self.sex = sex
//        self.age = age
    }
}
