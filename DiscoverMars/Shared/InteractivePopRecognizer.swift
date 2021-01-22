//
//  InteractivePopRecognizer.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/12/21.
//

import Foundation
import UIKit

/// Custom `InteractivePopGestureRecognizer` to allow screens that don't have a NavigationBar to swipe back to the previous screen.
class InteractivePopRecognizer: NSObject, UIGestureRecognizerDelegate {

    private var navigationController: UINavigationController

    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    // Enables swipe back gesture when there are more than one VCs in the UINavigationController's hierarchy
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController.viewControllers.count > 1
    }
    
    // This ensures that the subviews of the UINavigationController can't cancel out the gesture recognizer on the edge
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
