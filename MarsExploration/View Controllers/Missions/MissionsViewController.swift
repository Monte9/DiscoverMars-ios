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
    
    private var activityView: UIActivityIndicatorView!
    private var networkRetryCount: Int = 0
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "background")
        navigationItem.title = "All Missions"
        
        setupActivityIndicatory()
        fetchData()
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove the Back Button Label for all Child VCs
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: Activity Indicator
    
    func setupActivityIndicatory() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
    }
    
    // MARK: Network Requests
    
    private func fetchData() {
        activityView.startAnimating()
        
        NetworkManager.shared.fetchMissions() { result in
            self.activityView.stopAnimating()
            
            switch result {
            case .success(let missions):
                self.missions = missions
                
                self.populateData()
            case .failure(let error):
                print("Failed to fetch missions: \(error)")
                self.displayNetworkRetryAlert()
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
            
            // Setup and add MissionCard to the StackView
            let missionCard = setupMissionCard(for: mission)
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
    
    // MARK: Actions
    
    @objc func missionCardTapped(_ sender: MissionCard) {
        let missionDetailsViewController = MissionDetailsViewController(for: sender.mission)
        missionDetailsViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(missionDetailsViewController, animated: true)
    }
    
    // MARK: Helpers
    
    private func setupMissionCard(for mission: Mission) -> MissionCard {
        let missionCard = MissionCard(for: mission)
        
        missionCard.missionLabel.text = mission.missionName
        missionCard.roverLabel.text = "Rover: \(mission.roverName)"
        
        // Add roverImage
        missionCard.roverImage.loadImage(urlString: mission.roverImage) { (result) in
            switch result {
            case .success():
                print("Image loaded")
            case .failure(let error):
                print("Failed to load image: \(error)")
            }
        }
        
        // Setup height
        missionCard.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        // Setup tap action
        missionCard.isUserInteractionEnabled = true
        missionCard.addTarget(self, action: #selector(missionCardTapped(_:)), for: .touchUpInside)
        
        return missionCard
    }
    
    private func displayNetworkRetryAlert() {
        let alert = UIAlertController(title: "Unable to Connect", message: "Something went wrong. Please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: handleNetworkRetry))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func displayNetworkAlert() {
        let alert = UIAlertController(title: "Unable to Connect", message: "Please try again after sometime!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleNetworkRetry(alert: UIAlertAction) {
        guard networkRetryCount < 1  else {
            displayNetworkAlert()
            return
        }
        
        networkRetryCount += 1
        fetchData()
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
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
}
