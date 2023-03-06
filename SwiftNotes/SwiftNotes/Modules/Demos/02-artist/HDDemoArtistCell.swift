//
//  HDDemoArtistCell.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/5.
//  Copyright © 2023 Hegk. All rights reserved.
//

import UIKit

class HDDemoArtistCell: UITableViewCell {
    
    static let indentifier = "HDDemoArtistCellID"
        
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func addData (artist: HDDemoArtist) {
        avatarImage.image = artist.image
        descLabel.text = artist.desc
        nameLabel.text = artist.name
    }
    
    
}
