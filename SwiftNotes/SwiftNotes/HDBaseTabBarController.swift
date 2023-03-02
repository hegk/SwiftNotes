//
//  HDBaseTabBarController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/2/27.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

/*
 1. 根控制器的tabbar
 2. vc的tabbar
 3. tabbar的设置
 */

class HDBaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBarUI()
        //常规方式
        viewControllers = createViewControllers()
    }
    
    func configTabBarUI() {
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(hexString: "#d81e06")
    }
}

extension HDBaseTabBarController {
    func createViewControllers() -> Array<HDBaseNavigationController> {
        let navigationController1 = HDBaseNavigationController(rootViewController: HDHomeViewController())
        navigationController1.tabBarItem  = createTabBarItem(title: "Home", normalImageName: "tabbar_home_normal", selectedImageName: "tabbar_home_selected")
        
        let navigationController2 = HDBaseNavigationController(rootViewController: HDDemosViewController())
        navigationController2.tabBarItem  = createTabBarItem(title: "Demo", normalImageName: "tabbar_demo_normal", selectedImageName: "tabbar_demo_selected")
        
        let navigationController3 = HDBaseNavigationController(rootViewController: HDKitViewController())
        navigationController3.tabBarItem  = createTabBarItem(title: "Kit", normalImageName: "tabbar_kit_normal", selectedImageName: "tabbar_kit_selected")
        
        let navigationController4 = HDBaseNavigationController(rootViewController: HDMineViewController(title: "Mine⁺"))
        navigationController4.tabBarItem  = createTabBarItem(title: "Mine", normalImageName: "tabbar_mine_normal", selectedImageName: "tabbar_mine_selected", badgeValue: "0")
        
        return [navigationController1, navigationController2, navigationController3, navigationController4]
    }
    

    func createTabBarItem(title: String, normalImageName: String, selectedImageName: String, badgeValue: String, tag: Int) -> (UITabBarItem) {
        let tabBarItem = createTabBarItem(title: title, normalImageName: normalImageName, selectedImageName: selectedImageName, badgeValue: badgeValue)
        tabBarItem.tag = tag
        return tabBarItem
    }
    
    func createTabBarItem(title: String, normalImageName: String, selectedImageName: String, badgeValue: String) -> (UITabBarItem) {
        let tabBarItem = createTabBarItem(title: title, normalImageName: normalImageName, selectedImageName: selectedImageName)
        tabBarItem.badgeValue = badgeValue as String
        tabBarItem.badgeColor = UIColor.red
        return tabBarItem
    }
    
    func createTabBarItem(title: String, normalImageName: String, selectedImageName: String) -> (UITabBarItem) {
        let normalImage = UIImage(named: normalImageName)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        return tabBarItem
    }

}
