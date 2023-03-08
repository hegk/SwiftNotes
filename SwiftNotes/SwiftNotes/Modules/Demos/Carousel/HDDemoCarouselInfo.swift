//
//  HDDemoCarouselInfo.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/8.
//  Copyright © 2023 Hegk. All rights reserved.
//

/*
 Q:
 Function call causes an infinite recursion
 let infos: [HDDemoCarouselInfo]
 static func createInterests() -> [HDDemoCarouselInfo]
 
 
 */

import Foundation
import UIKit

struct HDDemoCarouselInfo {
    var id    = ""
    var title = ""
    var desc  = ""
    var numberOfMembers = 0
    var numberOfPosts   = 0
    var featuredImage: UIImage!
    
    init(id: String, title: String, description: String, featuredImage: UIImage!) {
        self.id    = id
        self.title = title
        self.desc  = description
        self.featuredImage = featuredImage
        numberOfMembers    = 1
        numberOfPosts      = 1
    }
    
    static func createInfos() -> [HDDemoCarouselInfo] {
       [
        HDDemoCarouselInfo(id: "r1", title: "We Love Traveling Around the World", description: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r1")!),
        HDDemoCarouselInfo(id: "r2", title: "Romance Stories", description: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r2")!),
        HDDemoCarouselInfo(id: "r3", title: "iOS Dev", description: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r3")!),
        HDDemoCarouselInfo(id: "r4", title: "Race", description: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r4")!),
        HDDemoCarouselInfo(id: "r5", title: "Personal Development", description: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r5")!),
        HDDemoCarouselInfo(id: "r6", title: "Reading News", description: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r6")!),
      ]
    }
}
