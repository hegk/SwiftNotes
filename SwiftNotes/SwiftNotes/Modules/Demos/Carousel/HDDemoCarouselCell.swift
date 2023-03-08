//
//  HDDemoCarouselCell.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/8.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

class HDDemoCarouselCell: UICollectionViewCell {
    
    static let indentifier = "HDDemoCarouselCellID"
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 300, width: 200, height: 30))
        titleLabel.backgroundColor = UIColor.green
        return titleLabel
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            
            // 在这里进行 cell 复用前的重置操作
        }
    
    var info: HDDemoCarouselInfo! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        titleLabel.text = info.title
        imageView.image = info.featuredImage
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
      
      self.layer.cornerRadius = 8.0
      self.clipsToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

