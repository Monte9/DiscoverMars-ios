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
        
        // Setup NavigationController
        let missionsViewController = MissionsViewController()
        let missionsNavigationController = UINavigationController(rootViewController: missionsViewController)
        missionsNavigationController.navigationBar.isTranslucent = false
        
        // Setup NavigationController
        let marsViewController = MarsViewController()
        let marsNavigationController = UINavigationController(rootViewController: marsViewController)
        marsNavigationController.navigationBar.isTranslucent = false
        
        // Setup TabBarController with VCs
        let rootTabBarController = UITabBarController()
        rootTabBarController.viewControllers = [marsNavigationController, missionsNavigationController]
        
        // Setup TabBarItem Labels
        rootTabBarController.tabBar.items?[0].title = "Missions"
        rootTabBarController.tabBar.items?[1].title = "Mars"
        
        // Customize TabBar appearance
        UITabBar.appearance().barTintColor = UIColor(named: "background")
        UITabBar.appearance().isTranslucent = false
        
        // Setup TabBarItem Appearance
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.init(named: "orange")!
        ], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.init(named: "orange")!
        ], for: .selected)
        
        // Set the UIOffset for the tabBarItem title based on device type
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: tabBarTitleVerticalOffset(for: rootTabBarController))
        
        // Add underline to the text to indicate selected tab
        UITabBar.appearance().selectionIndicatorImage = tabBarItemUnderlineImage(for: rootTabBarController)
        
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
    
    func tabBarItemUnderlineImage(for rootTabBarController: UITabBarController) -> UIImage {
        let lineHeight: CGFloat = 2
        
        let tabBarItemWidth = rootTabBarController.tabBar.frame.width / 2
        let tabBarItemHeight = rootTabBarController.tabBar.frame.height
        let size = CGSize(width: tabBarItemWidth, height: tabBarItemHeight)
        var titleWidth: CGFloat = 0
        var titleHeight: CGFloat = 0
        
        if let font = UIFont(name: "Inter-Medium", size: 24) {
            let fontAttributes = [NSAttributedString.Key.font: font]
            let myText = rootTabBarController.tabBar.items?[0].title
            let titleSize = myText?.size(withAttributes: fontAttributes)
            titleWidth = titleSize?.width ?? tabBarItemWidth
            titleHeight = titleSize?.height ?? tabBarItemHeight-lineHeight
        }
        
        // Get the starting point for underLineRect so it's centered
        let centerStartPoint = (tabBarItemWidth / 2) - (titleWidth / 2)
        
        // Setup the tabBarItemRect and underLineRect sizes
        let tabBarItemRect = CGRect(x: 0, y: 0, width: tabBarItemWidth, height: tabBarItemHeight)
        let underLineRect = CGRect(x: centerStartPoint, y: titleHeight + 8, width: titleWidth, height: lineHeight)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        // Set the backgroundColor for tabBarItemRect
        UIColor.clear.setFill()
        UIRectFill(tabBarItemRect)
        
        // Set the backgroundColor for underLineRect
        UIColor(named: "orange")?.setFill()
        UIRectFill(underLineRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func tabBarTitleVerticalOffset(for rootTabBarController: UITabBarController) -> CGFloat {
        let tabBarItemHeight: CGFloat = rootTabBarController.tabBar.frame.height
        
        if UIDevice.current.isIPhoneXOrBigger {
            return -tabBarItemHeight/16
        } else if UIDevice.current.isIpad {
            return 0
        } else {
            return -tabBarItemHeight/4
        }
    }
}
