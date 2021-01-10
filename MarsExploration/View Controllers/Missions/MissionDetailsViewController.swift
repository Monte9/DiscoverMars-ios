//
//  MissionDetailsViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/9/21.
//

import Foundation
import UIKit

class MissionDetailsViewController: UIViewController {
    
    // MARK: Initialization
    
    private let mission: Mission
    init(for mission: Mission) {
        self.mission = mission
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "background")
        title = mission.missionName
        
        setupViews()
        setupConstraints()
        
        populateData()
    }
    
    // MARK: Populate Data
    
    private func populateData() {
        let missionLabel = setupLabel(with: mission.missionName)
        let roverName = setupLabel(with: mission.roverName)
        let status = setupLabel(with: mission.status)
        let maxDate = setupLabel(with: mission.maxDate)
        let launchDate = setupLabel(with: mission.launchDate)
        let landingDate = setupLabel(with: mission.landingDate)
        let maxSol = setupLabel(with: String(mission.maxSol.withCommas()))
        let totalPhotos = setupLabel(with: String(mission.totalPhotos.withCommas()))
        
        [missionLabel, roverName, status, maxDate, launchDate, landingDate, maxSol, totalPhotos].forEach{
            stackView.addArrangedSubview($0)
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
    
    // MARK: Helpers
    
    private func setupLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = .systemFont(ofSize: 20)
        return label
    }
    
    // MARK: UI Views
    
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
