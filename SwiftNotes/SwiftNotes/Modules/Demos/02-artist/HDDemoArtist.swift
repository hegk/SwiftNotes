//
//  HDDemoArtist.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/6.
//  Copyright © 2023 Hegk. All rights reserved.
//


/*
 Q:artists 的 let  ?  work 的let 不需要
 Q:关键路径 绝对路径  Xcode path  实际安装包path   FileManager 和 Bundle
 Q: if let image的弊端
 Q: let imageName = artist["image"]  as? String,
    let image = UIImage(named: "imageName"),
    当image或者image为空的时结束，注意不需要结束的场景比如使用占位或者是单纯不显示即可
 */

import Foundation
import UIKit

struct HDDemoArtist {
    let name: String
    let desc: String
    let image: UIImage
    var works: [HDDemoWork]
    
    init(name: String, desc: String, image: UIImage, works: [HDDemoWork]) {
        self.name  = name
        self.desc  = desc
        self.image = image
        self.works = works
    }
    
    
    static func artistsFromBundle() -> [HDDemoArtist] {
        var artists = [HDDemoArtist]()
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artists
        }
        
        do {
            
            
            let data = try Data(contentsOf: url)
            guard let rootObjet = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                return artists
            }
            
            guard let artistsDict = rootObjet["artists"] as? [[String: Any]] else {
                return artists
            }
            
            for artist in artistsDict {
                if let name = artist["name"] as? String,
                   let desc = artist["bio"] as? String,
//                   let imageName = artist["image"]  as? String,
                   let image = UIImage(named: "artist_placeholder"),
                   let worksDict = artist["works"] as? [[String : String]] {
                    var works = [HDDemoWork]()
                    for work in worksDict {
                        if let title = work["title"],
//                           let imageName = work["image"],
                           let image = UIImage(named: "artist_placeholder"),
                           let info = work["info"] {
                            works.append(HDDemoWork(title: title, image: image, info: info, isExpanded: false))
                        }
                    }
                    
                    let artist = HDDemoArtist(name: name, desc: desc, image: image, works: works)
                    artists.append(artist)
                }
            }
        } catch {
            return artists
        }
        
        return artists
    }
}



