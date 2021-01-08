//
//  MissionsViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/9/21.
//

import Foundation
import UIKit

class MissionsViewController: UIViewController {
    
    private var missions: [Mission]?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "background")
        title = "All Missions"
        
        fetchData()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: Network Requests
    
    private func fetchData() {
        NetworkManager.shared.fetchMissions() { result in
            switch result {
            case .success(let missions):
                self.missions = missions
                
                self.populateData()
            case .failure(let error):
                print("Failed to fetch missions: \(error)")
            }
        }
    }
    
    // MARK: Populate Data
    
    private func populateData() {
        guard let missions = missions else {
            return
        }
        
        for index in 0..<missions.count {
            let mission = missions[index]
            
            // Add extra padding to the top of the first card
            if (index == 0) {
                let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 24))
                stackView.addArrangedSubview(spacerView)
            }
            
            let missionCard = MissionCard()
            missionCard.missionLabel.text = mission.missionName
            missionCard.roverLabel.text = "Rover: \(mission.roverName)"
            missionCard.roverImage.loadImage(urlString: mission.roverImage) { (result) in
                switch result {
                case .success():
                    print("Image loaded")
                case .failure(let error):
                    print("Failed to load image: \(error)")
                }
            }
            missionCard.heightAnchor.constraint(equalToConstant: 320).isActive = true
            
            stackView.addArrangedSubview(missionCard)
            
            // Add extra padding to the bottom of the last card
            if index == (missions.count - 1) {
                let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 24))
                stackView.addArrangedSubview(spacerView)
            }
        }
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
    
    // MARK: UI Components
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}

