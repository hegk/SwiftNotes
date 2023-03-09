//
//  HDDemoRoster.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/9.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit


enum ResourceState {
    case New, Download, Filtered, Failed
}

struct HDDemoRoster {
    let name: String
    let url: URL
    var state = ResourceState.New
    var image = UIImage(named: "artist_placeholder")
    
    init(name: String, url: URL) {
        self.name = name
        self.url  = url
    }
}




