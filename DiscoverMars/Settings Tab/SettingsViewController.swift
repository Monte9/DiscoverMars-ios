//
//  SettingsViewController.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/5/21.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private let settings: [Setting] = [
        Setting(title: "Monte Thakkar", subtitle: "Development", url: "https://twitter.com/MThakkar_"),
        Setting(title: "Spencer Everett", subtitle: "Design", url: "https://twitter.com/SP3V"),
        Setting(title: "NASA", subtitle: "API", url: "https://github.com/chrisccerami/mars-photo-api"),
        Setting(title: "Share Discover Mars", url: "https://github.com/chrisccerami/mars-photo-api"),
        Setting(title: "Follow us on Twitter", url: "https://github.com/chrisccerami/mars-photo-api"),
        Setting(title: "Contact us", url: "https://github.com/chrisccerami/mars-photo-api"),
    ]
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "orange")
        
        setupViews()
        setupConstraints()
        
        setupSettingsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Remove the title from the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Set the tint and background color for the navigation bar
        UINavigationBar.appearance().barTintColor = UIColor(named: "background")
        UINavigationBar.appearance().tintColor = UIColor(named: "orange")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "orange") ?? .white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // Show the Navigation Bar for all Child VCs
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        return isDarkMode ? .darkContent : .lightContent
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    private func setupSettingsView() {
        settings.forEach { setting in
            let settingsRow = SettingsRow()
            settingsRow.titleLabel.text = setting.title
            if let subtitle = setting.subtitle, !subtitle.isEmpty {
                settingsRow.shouldDisplaySubtitle = true
                settingsRow.subtitleLabel.text = setting.subtitle
            } else {
                settingsRow.shouldDisplaySubtitle = false
            }
            
            stackView.addArrangedSubview(settingsRow)
        }
    }
    
    // MARK: UI Views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}
