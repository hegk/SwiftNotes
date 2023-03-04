//
//  HDDemoMineCell.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/4.
//  Copyright © 2023 Hegk. All rights reserved.
//

import UIKit

/*
 Q:为什么一定要实现
 required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
 }
 */

class HDDemoMineCell: UITableViewCell {
    static let identifier = "HDDemoMineCellID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor      = UIColor.white
        textLabel?.textColor = UIColor.black
        textLabel?.font      = UIFont.systemFont(ofSize: 16)
        
        detailTextLabel?.textColor = UIColor.gray
        detailTextLabel?.font      = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

