//
//  HDDemoWorkCell.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/7.
//  Copyright © 2023 Hegk. All rights reserved.
//

/*
 Q: indentifier  为什么 HDDemoWorkCell 和 HDDemoArtistCell 中 indentifier 同名 static  不冲突
 */

import UIKit

class HDDemoWorkCell: UITableViewCell {
    
    static let indentifier = "HDDemoWorkCellID"
    
    let moreInfoText = "Select For More Info >"

    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    func addData(work: HDDemoWork) {
        workImageView.image = work.image
        nameLabel.text = work.title
        if work.isExpanded {
            descLabel.text = moreInfoText;
            descLabel.textAlignment = .center
        } else {
            descLabel.text = work.info
            descLabel.textAlignment = .left
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
