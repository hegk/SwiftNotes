//
//  HDDemoMinePopulate.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/4.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation

/*
 Q: HDDemoMinePopulate前加public的作用和HDDemoMineUser相比如何,  合在HDDemoMineUser中可行
 Q: 没有包的概念，如何解决文件名前缀过长的问题
 */





public struct HDDemoMinePopulate {
    static let SectionTitle = "sectionTitle"
    static let Rows         = "rows"
    static let ImageName    = "imageName"
    static let Title        = "title"
    static let SubTitle     = "subTitle"
    static let seeMore      = "See More..."
    static let addFavorites = "Add Favorites"
    static let logout       = "Log Out"
    
    
    static func populate(withUser user: HDDemoMineUser) -> [[String: Any]] {
        
        return [
            [
                HDDemoMinePopulate.Rows : [
                    [
                        HDDemoMinePopulate.Title     : user.name,
                        HDDemoMinePopulate.ImageName : user.avatarName,
                        HDDemoMinePopulate.SubTitle  : "View your profile"
                    ]]
            ],
            
            [
                HDDemoMinePopulate.Rows : [
                    [
                        HDDemoMinePopulate.Title     : "Friends",
                        HDDemoMinePopulate.ImageName : "",
                    ],
                    [
                        HDDemoMinePopulate.Title     : "Events",
                        HDDemoMinePopulate.ImageName : "",
                    ],
                    [
                        HDDemoMinePopulate.Title     : "Groups",
                        HDDemoMinePopulate.ImageName : "",
                    ],
                    [
                        HDDemoMinePopulate.Title     : "Town Hall",
                        HDDemoMinePopulate.ImageName : "",
                    ],
                    [
                        HDDemoMinePopulate.Title     : "Instant Games",
                        HDDemoMinePopulate.ImageName : "",
                    ],
                    [
                        HDDemoMinePopulate.Title     : HDDemoMinePopulate.seeMore,
                    ],
                
                ]
            ],
         
            [
                HDDemoMinePopulate.SectionTitle : "FAVORITES",
                HDDemoMinePopulate.Rows : [
                    [
                        HDDemoMinePopulate.Title     : HDDemoMinePopulate.addFavorites,
                    ]]
            ],
            
            [
                HDDemoMinePopulate.Rows : [
                    [
                        HDDemoMinePopulate.Title     : "Privacy Shortcuts",
                        HDDemoMinePopulate.ImageName : "",
                        HDDemoMinePopulate.SubTitle  : "Help and Support"
                    ]]
            ],
            
            [
                HDDemoMinePopulate.Rows : [
                    [
                        HDDemoMinePopulate.Title     : HDDemoMinePopulate.logout,
                    ]]
            ],
            
        ]
    }
    
    
    
    
}



