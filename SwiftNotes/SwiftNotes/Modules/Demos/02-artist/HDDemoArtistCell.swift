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
    
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//
//
//
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
}
