//
//  HDDemoMineUser.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/4.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation

struct HDDemoMineUser {
    var name, avatarName, education: String
    
    init(name: String, avatarName: String = "X", education: String) {
        self.name       = name
        self.avatarName = avatarName
        self.education  = education
    }
}
