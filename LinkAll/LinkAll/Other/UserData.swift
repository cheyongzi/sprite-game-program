//
//  UserData.swift
//  LinkAll
//
//  Created by che on 15/11/19.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import Foundation

class UserData {
    
    static func saveUserData(currentGameIndex: Int, sceneIndex: Int) {
        if currentGameIndex > NSUserDefaults.standardUserDefaults().integerForKey("\(sceneIndex)") {
            NSUserDefaults.standardUserDefaults().setInteger(currentGameIndex, forKey: "\(sceneIndex)")
        }
    }
}