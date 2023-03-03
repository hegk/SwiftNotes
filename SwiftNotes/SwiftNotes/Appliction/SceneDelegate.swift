//
//  SceneDelegate.swift
//  SwiftNotes
//
//  Created by Hegk on 2023/2/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var scene1: UIWindowScene?
    var scene2: UIWindowScene?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        configScene(scene: scene)
    }
    
    func configScene(scene: UIScene) {
        if scene.session.configuration.name == "Default Configuration" {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let mainWindow = UIWindow(windowScene: windowScene)
            
            let tabBarController = HDBaseTabBarController()
            
            mainWindow.rootViewController = tabBarController

            mainWindow.backgroundColor = UIColor.white
            mainWindow.makeKeyAndVisible()
            self.window = mainWindow;
            self.scene1 = windowScene;
            
        } else {
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let mainWindow = UIWindow(windowScene: windowScene)
            
            let rootVC = HDMineViewController(title: "")
            
            mainWindow.rootViewController = rootVC
            mainWindow.backgroundColor = UIColor.white
            mainWindow.makeKeyAndVisible()
            self.window = mainWindow
            self.scene2 = windowScene
        }
    }
    
    
    
    /// scene已经断开
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        if scene.session.configuration.name == "name" {
            self.scene1 = nil
        } else {
            self.scene2 = nil
        }
    }
    
    /// scene已经被激活
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    // 创建一个新场景
    func createScene(withIdentifier identifier: String) {
        guard let sceneSession = UIApplication.shared.openSessions.first(where: { $0.configuration.name == identifier }) else {
            return
        }
        
        UIApplication.shared.requestSceneSessionActivation(sceneSession, userActivity: nil, options: nil, errorHandler: { error in
            print("Failed to create new scene: \(error)")
        })
    }



}

