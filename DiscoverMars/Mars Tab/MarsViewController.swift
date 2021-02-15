//
//  MarsViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/9/21.
//

import Foundation
import UIKit

class MarsViewController: UIViewController {
    
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
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        let allMarsFacts = Array(MarsFact.allCases)
        
        for index in 0..<allMarsFacts.count {
            let marsFact = allMarsFacts[index]
            
            // Add extra padding to the top of the first card
            if (index == 0) {
                let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 24))
                stackView.addArrangedSubview(spacerView)
            }
            
            // Setup and add MarsFactCard to the StackView
            let marsFactCard = setupMarsFactCard(with: marsFact)
            marsFactCard.cardCountView.countLabel.text = "\(index + 1) - \(allMarsFacts.count)"
            stackView.addArrangedSubview(marsFactCard)
            
            // Add extra padding to the bottom of the last card
            if index == (allMarsFacts.count - 1) {
                let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 24))
                stackView.addArrangedSubview(spacerView)
            }
        }
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
    
    // MARK: Helpers
    
    private func setupMarsFactCard(with marsFact: MarsFact) -> MarsFactCard {
        let marsFactCard = MarsFactCard(for: marsFact)
        marsFactCard.titleLabel.text = marsFact.title()
        marsFactCard.subtitleLabel.text = marsFact.subtitle()
        marsFactCard.descriptionText = marsFact.description()
        marsFactCard.factImage.image = UIImage(named: marsFact.imageName())
        return marsFactCard
    }
    
    // Called when the user interface changes between light and dark mode
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // We re-set the image on the MarsFactCard so we get the update light/dark image
        stackView.subviews.forEach { view in
            if let marsFactCard = view as? MarsFactCard {
                marsFactCard.factImage.image = UIImage(named: marsFactCard.fact.imageName())
            }
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
        stackView.spacing = 24
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}
