//
//  ViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var missions: [Mission]?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "background")
        
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
        missions?.forEach({ mission in
            let missionCard = MissionCard()
            missionCard.missionLabel.text = mission.missionName
            missionCard.roverLabel.text = mission.roverName
            missionCard.heightAnchor.constraint(equalToConstant: 250).isActive = true
            
            stackView.addArrangedSubview(missionCard)
        })
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
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
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
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}
