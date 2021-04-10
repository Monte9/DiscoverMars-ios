//
//  WhatsNewViewController.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/10/21.
//

import Foundation
import UIKit

class WhatsNewViewController: UIViewController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "orange")
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Remove the title from the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Set the navigation bar title
        title = "What's New?"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Set the tint and background color for the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(named: "orange")
        navigationController?.navigationBar.tintColor = UIColor(named: "background")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "background") ?? .white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "background") ?? .white]
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(scrollView)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: UI Views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
}
