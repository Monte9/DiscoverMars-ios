//
//  SettingsViewController.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/5/21.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsSections: KeyValuePairs = [
        "Updates": [
            Setting(title: "See what’s new", url: "https://github.com/chrisccerami/mars-photo-api")
        ],
        "Contributors": [
            Setting(title: "Monte Thakkar", subtitle: "Development", url: "https://twitter.com/MThakkar_"),
            Setting(title: "Spencer Everett", subtitle: "Design", url: "https://twitter.com/SP3V"),
            Setting(title: "NASA", subtitle: "API", url: "https://github.com/chrisccerami/mars-photo-api"),
        ],
        "Engagement": [
            Setting(title: "Share Discover Mars", url: "https://github.com/chrisccerami/mars-photo-api"),
            Setting(title: "Follow us on Twitter", url: "https://github.com/chrisccerami/mars-photo-api"),
            Setting(title: "Contact us", url: "https://github.com/chrisccerami/mars-photo-api"),
        ],
    ]
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "orange")
        
        setupViews()
        setupConstraints()
        
        setupSettingsSections()
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
        scrollView.addSubview(spacerViewTop)
        scrollView.addSubview(stackView)
        scrollView.addSubview(spacerViewBottom)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spacerViewTop.topAnchor.constraint(equalTo: scrollView.topAnchor),
            spacerViewTop.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            spacerViewTop.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            spacerViewTop.heightAnchor.constraint(equalToConstant: 24),
            stackView.topAnchor.constraint(equalTo: spacerViewTop.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            spacerViewBottom.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            spacerViewBottom.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            spacerViewBottom.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            spacerViewBottom.heightAnchor.constraint(equalToConstant: 24),
            spacerViewBottom.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setupSettingsSections() {
        settingsSections.forEach { (sectionTitle, settings) in
            let section = SettingsSection(settings: settings)
            section.titleLabel.text = sectionTitle
            stackView.addArrangedSubview(section)
        }
    }
    
    // MARK: UI Views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let spacerViewTop: UIView = {
        let spacerView = UIView()
        spacerView.backgroundColor = .red
        spacerView.translatesAutoresizingMaskIntoConstraints =  false
        return spacerView
    }()
    
    private let spacerViewBottom: UIView = {
        let spacerView = UIView()
        spacerView.backgroundColor = .red
        spacerView.translatesAutoresizingMaskIntoConstraints =  false
        return spacerView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}
