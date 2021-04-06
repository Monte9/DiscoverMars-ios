//
//  SceneDelegate.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import UIKit

// Shared Design Assets
// Mars Photo API: https://github.com/chrisccerami/mars-photo-api
// SF Symbols List: https://hotpot.ai/free-icons?s=sfSymbols
// Mars Default Color Palette: https://www.color-hex.com/color-palette/7276
// Mars Pale Color Palette: https://www.color-hex.com/color-palette/7175
// iOS Fonts: https://gist.github.com/tadija/cb4ec0cbf0a89886d488d1d8b595d0e9
// Create Production scheme:  https://ahadsheriff.medium.com/how-to-rename-an-xcode-project-without-losing-your-mind-88e558fb7566
// Sending an email: https://www.hackingwithswift.com/example-code/uikit/how-to-send-an-email

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // Setup Missions NavigationController
        let missionsViewController = MissionsViewController()
        let missionsNavigationController = UINavigationController(rootViewController: missionsViewController)
        missionsNavigationController.navigationBar.isTranslucent = false
        
        // Setup Mars NavigationController
        let marsViewController = MarsViewController()
        let marsNavigationController = UINavigationController(rootViewController: marsViewController)
        marsNavigationController.navigationBar.isTranslucent = false
        
        // Setup Settings NavigationController
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        marsNavigationController.navigationBar.isTranslucent = false
        
        // Setup TabBarController with 3 ViewControllers
        let rootTabBarController = UITabBarController()
        rootTabBarController.viewControllers = [
            settingsNavigationController,
            missionsNavigationController,
            marsNavigationController,
        ]
        
        // Customize TabBar appearance
        UITabBar.appearance().barTintColor = UIColor(named: "background")
        UITabBar.appearance().isTranslucent = false
        
        // Custom title for TabBarItem
        let title = UIDevice.current.isIpad ? "" : nil
        
        // Custom image offset for TabBarItem
        let offset: CGFloat = UIDevice.current.isIPhoneXOrBigger ? 9 : 5
        let edgeInset = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        
        // Setup Missions TabBarItem title & images
        rootTabBarController.tabBar.items?[0].title = title
        rootTabBarController.tabBar.items?[0].image = UIImage(named: "missions.tabbar.item")?.withRenderingMode(.alwaysOriginal)
        rootTabBarController.tabBar.items?[0].selectedImage = UIImage(named: "missions.tabbar.item.selected")
        if !UIDevice.current.isIpad {
            rootTabBarController.tabBar.items?[0].imageInsets = edgeInset
        }
        
        // Setup Mars TabBarItem title & images
        rootTabBarController.tabBar.items?[1].title = title
        rootTabBarController.tabBar.items?[1].image = UIImage(named: "mars.tabbar.item")?.withRenderingMode(.alwaysOriginal)
        rootTabBarController.tabBar.items?[1].selectedImage = UIImage(named: "mars.tabbar.item.selected")
        if !UIDevice.current.isIpad {
            rootTabBarController.tabBar.items?[1].imageInsets = edgeInset
        }
        
        // Setup Settings TabBarItem title & images
        rootTabBarController.tabBar.items?[2].title = title
        rootTabBarController.tabBar.items?[2].image = UIImage(named: "settings.tabbar.item")?.withRenderingMode(.alwaysOriginal)
        rootTabBarController.tabBar.items?[2].selectedImage = UIImage(named: "settings.tabbar.item.selected")
        if !UIDevice.current.isIpad {
            rootTabBarController.tabBar.items?[2].imageInsets = edgeInset
        }
        
        window?.rootViewController = rootTabBarController
        window?.makeKeyAndVisible()
        window?.tintColor = UIColor(named: "orange")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
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
}
