//
//  HDShopTabBarController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/1.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

class HDShopTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [homeTab, profileTab, moreTab]
    }
    
    lazy var homeTab: UIViewController = {
        let homeTabItem = UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), selectedImage: nil)
        let homeNavTab = HDHomeViewController()
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    lazy var profileTab: UIViewController = {
        let randomTabItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_profile"), selectedImage: nil)
        let navController = HDKitViewController()
        navController.tabBarItem = randomTabItem
        return navController
    }()


    lazy var moreTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "More", image: UIImage(named: "ic_settings"), selectedImage: nil)
        let navController =  HDMineViewController(title: "")
        navController.tabBarItem = commentTabItem
        return navController
    }()
    
}
