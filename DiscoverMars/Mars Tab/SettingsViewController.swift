//
//  SettingsViewController.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 3/5/21.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title for the navigation bar
        title = "Settings"
        
        // Set the background color for the view
        view.backgroundColor = UIColor.init(named: "orange")
        
        // Add the close bar button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply.circle.fill"), style: .plain, target: self, action: #selector(closeBarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "background")
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Change the tint and background color for the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(named: "orange")
        navigationController?.navigationBar.tintColor = UIColor(named: "orange")
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "background")!,
            NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 18)!,
        ]
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    // MARK: Actions
    
    @objc private func closeBarButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UI Views
    
    
}
