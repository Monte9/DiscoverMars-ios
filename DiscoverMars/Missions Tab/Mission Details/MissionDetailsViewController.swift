//
//  MissionDetailsViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/9/21.
//

import Foundation
import UIKit
import NYTPhotoViewer

class MissionDetailsViewController: SwipeableTopTabBarController {
    
    private weak var defaultGestureRecognizerDelegate: UIGestureRecognizerDelegate?
    private var customPopRecognizer: InteractivePopRecognizer?
    
    private var isPhotoViwerModalShown: Bool = false
    
    // MARK: Initialization
    
    private let mission: Mission
    init(for mission: Mission) {
        self.mission = mission
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the navigation bar title
        title = mission.roverName
        
        // Remove bottom line on navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // Set the background color for the view
        view.backgroundColor = UIColor.init(named: "background")
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Enable swipe back gesture from child VC to root VC
        if let navigationController = navigationController {
            // Saves the default gestureRecognizerDelegate of the UINavigationController so it can be restored later
            defaultGestureRecognizerDelegate = navigationController.interactivePopGestureRecognizer?.delegate

            // Set the custom gestureRecognizerDelegate on the UINavigationController to enable swipe back gesture
            customPopRecognizer = InteractivePopRecognizer(navController: navigationController)
            navigationController.interactivePopGestureRecognizer?.delegate = customPopRecognizer
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // Hide the navigation bar only when the photoViewer Modal is not shown
        if isPhotoViwerModalShown == false {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        // slidingTab
        addTab(viewController: PhotosViewController(for: mission, delegate: self), title: "Photos")
        addTab(viewController: AboutViewController(for: mission), title: "About")
        setup()
    }
}

// MARK: - PhotosViewControllerDelegate

extension MissionDetailsViewController: PhotosViewControllerDelegate {
    
    func didSelectPhotoCellView(from viewController: UIViewController, photoViewer: NYTPhotosViewController) {
        isPhotoViwerModalShown = true
        present(photoViewer, animated: true, completion: nil)
    }
    
    func didDismissPhotoViewerModal(from viewController: UIViewController) {
        isPhotoViwerModalShown = false
    }
}
