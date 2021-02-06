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
    
    private var activityView: UIActivityIndicatorView?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "orange")
        
        fetchData()
        
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
    
    // MARK: Activity Indicator
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    // MARK: Network Requests
    
    private func fetchData() {
        showActivityIndicator()
        
        NetworkManager.shared.fetchMissions() { result in
            self.hideActivityIndicator()

            switch result {
            case .success(let missions):
                self.missions = missions

                self.populateData()
            case .failure(let error):
                print("Failed to fetch missions: \(error)")
                self.displayErrorView()
            }
        }
    }
    
    // MARK: Populate Data
    
    private func populateData() {
        // No missions to display
        guard let missions = missions else {
            return
        }
        
        // Setup StackView
        scrollView.addSubview(stackView)
        
        // Add Missions to the StackView
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
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    // MARK: Error View
    
    private func displayErrorView() {
        scrollView.addSubview(errorTitleLabel)
        scrollView.addSubview(retryButton)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            errorTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            errorTitleLabel.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            retryButton.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 4),
            retryButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
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
    
    // MARK: Actions
    
    @objc func missionCardTapped(_ sender: MissionCard) {
        let missionDetailsViewController = PhotosViewController(for: sender.mission)
        missionDetailsViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(missionDetailsViewController, animated: true)
    }
    
    @objc func retryNetworkRequest(_ sender: UIButton) {
        scrollView.subviews.map { $0.removeFromSuperview() }
        
        fetchData()
    }
    
    // MARK: Helpers
    
    private func setupMissionCard(for mission: Mission) -> MissionCard {
        let missionCard = MissionCard(for: mission)
        
        missionCard.roverLabel.text = mission.roverName
        missionCard.missionLabel.text = mission.missionName
        
        // Add roverImage
        missionCard.roverImage.image = UIImage(named: mission.roverName.lowercased())
        
        // Setup height
        missionCard.heightAnchor.constraint(equalToConstant: Constants.isIpad ? 330 : 232).isActive = true
        
        // Setup tap action
        missionCard.isUserInteractionEnabled = true
        missionCard.addTarget(self, action: #selector(missionCardTapped(_:)), for: .touchUpInside)
        
        return missionCard
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
    
    private let errorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Unable to Connect"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("RETRY", for: .normal)
        button.setTitleColor(UIColor(named: "orange"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(retryNetworkRequest), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
