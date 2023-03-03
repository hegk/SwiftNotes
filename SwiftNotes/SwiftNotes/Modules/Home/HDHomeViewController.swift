//
//  HDHomeViewController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/2/28.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

class HDHomeViewController: HDBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneTest()
    }
    
    
    func sceneTest() {
        // 在点击按钮时创建一个新场景
        let button = UIButton(type: .system)
        button.setTitle("Create New Scene", for: .normal)
        button.addTarget(self, action: #selector(createShopHome), for: .touchUpInside)
        view.addSubview(button)
        
        // 布局按钮
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func createNewScene() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("Failed to access the SceneDelegate")
        }
        sceneDelegate.createScene(withIdentifier: "name")
    }
    
    @objc private func createShopHome() {
    
        let shopHomeTC = HDShopTabBarController()
        shopHomeTC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(shopHomeTC, animated: true)
        
    }

    
    
    
}
