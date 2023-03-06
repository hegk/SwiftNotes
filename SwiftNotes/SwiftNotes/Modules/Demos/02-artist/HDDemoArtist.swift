//
//  HDDemoArtist.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/6.
//  Copyright © 2023 Hegk. All rights reserved.
//


/*
 Q:artists 的 let  ?  work 的let 不需要

 
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
                   let imageName = artist["iamge"]  as? String,
                   let image = UIImage(named: imageName),
                   let worksDict = artist["works"] as? [[String : String]] {
                    var works = [HDDemoWork]()
                    for work in worksDict {
                        if let title = work["title"],
                           let imageName = work["image"],
                           let image = UIImage(named: imageName + ".jpg"),
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



