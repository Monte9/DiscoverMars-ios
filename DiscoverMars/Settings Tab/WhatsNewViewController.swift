//
//  WhatsNewViewController.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/10/21.
//

import Foundation
import UIKit

class WhatsNewViewController: UIViewController {
    
    private let whatsNewSections = [
        WhatsNew(type: .summaryOnly, number: nil, title: nil, summary: "The Discover Mars app provides easy access to images taken on Mars by the NASA Mars rovers.\n\nHere’s a quick digest of some of the changes in Version \(UIDevice().appVersion) that we wanted you to know about beyond bug fixes and performance improvements."),
        WhatsNew(type: .all, number: "01", title: "Images from Perseverance Rover", summary: "View latest images taken on Mars by the Perseverance, Curiosity, Opportunity, and Spirit rovers."),
        WhatsNew(type: .all, number: "02", title: "Immersive Photo Viewing Experience", summary: "Tapping on a photo launches it in slideshow mode to view the full high-defintion image. You can double tap to zoom into an photo or tap on the Share icon to save images directly onto your iPhone."),
        WhatsNew(type: .all, number: "03", title: "Learn About Mars", summary: "The Mars tab provides interesting visuals about various aspect of Mars such as it's atmosphere, gravity, temperature and much more."),
        WhatsNew(type: .summaryOnly, number: "04", title: "", summary: "Please send us any feedback you have: discovermarsapp@gmail.com\n\nAs always, thank you! And discover on.\n\n❤️ Spencer & Monte 🚀"),
    ]
    
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
        for (index, whatsNewSection) in whatsNewSections.enumerated() {
            let section = WhatsNewSection(section: whatsNewSection)
            
            if index == whatsNewSections.count - 1 {
                section.isLastSection = true
            }
            
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
}
