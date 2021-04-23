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
        
        view.backgroundColor = UIColor(named: "background")
        
        // Set the navigation bar title
        title = "What's New?"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Remove the title from the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Setup rightBarButtonItem on navigationbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeButtonTapped))
        
        // Set the tint and background color for the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        navigationController?.navigationBar.tintColor = UIColor(named: "orange")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "orange") ?? .white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "orange") ?? .white]
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        // Add sections to the stackView
        [section01, section02, section03, section04, section05].forEach { section in
            stackView.addArrangedSubview(section)
        }
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    // MARK: Actions
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
        stackView.spacing = 24
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let section01: WhatsNewSection = {
        let section = WhatsNewSection()
        return section
    }()
    
    private let section02: WhatsNewSection = {
        let section = WhatsNewSection()
        return section
    }()
    
    private let section03: WhatsNewSection = {
        let section = WhatsNewSection()
        return section
    }()
    
    private let section04: WhatsNewSection = {
        let section = WhatsNewSection()
        return section
    }()
    
    private let section05: WhatsNewSection = {
        let section = WhatsNewSection()
        return section
    }()
}
