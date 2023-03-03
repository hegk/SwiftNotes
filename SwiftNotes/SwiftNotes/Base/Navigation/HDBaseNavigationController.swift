//
//  HDBaseNavigationController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/2/28.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

/*
 1. 设置
 2. 隐藏
 3. 自定义
 4. 特殊页面的自定义
 */

class HDBaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
    }
    
    
    func configUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = .lightGray
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.gray
        navigationBar.isTranslucent = false
    }
    
    
}
