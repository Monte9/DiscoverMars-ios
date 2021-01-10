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
        // Mission Overview
        let typeInfoView = InfoView(title: "Mission Type".uppercased(), subtitle: "Rover: \"\(mission.roverName)\"")
        
        // Misson Status
        let statusInfoView = InfoView(title: "Mission Status".uppercased(), subtitle: mission.status)
        let lastContactInfoView = InfoView(title: "Last Contact".uppercased(), subtitle: mission.maxDate)
        
        // Launch Summary
        let launchDateInfoView = InfoView(title: "Launch".uppercased(), subtitle: mission.launchDate)
        let launchVehicleInfoView = InfoView(title: "Launch Vehicle".uppercased(), subtitle: mission.launchVehicle)
        let launchLocationInfoView = InfoView(title: "Launch Location".uppercased(), subtitle: mission.launchLocation)
        
        // Landing Summary
        let landingDateInfoView = InfoView(title: "Landing".uppercased(), subtitle: mission.landingDate)
        let landingSiteInfoView = InfoView(title: "Landing Site".uppercased(), subtitle: mission.landingSite)
        
        // Mission Overview
        let overviewInfoView = InfoView(title: "Overview".uppercased(), subtitle: mission.overview)
        
        [spacerView, missionLabel, typeInfoView, statusInfoView, lastContactInfoView,
         launchDateInfoView, launchVehicleInfoView, launchLocationInfoView,
         landingDateInfoView, landingSiteInfoView, overviewInfoView
        ].forEach { stackView.addArrangedSubview($0) }
        
        stackView.setCustomSpacing(32.0, after: lastContactInfoView)
        stackView.setCustomSpacing(32.0, after: launchLocationInfoView)
        stackView.setCustomSpacing(32.0, after: landingSiteInfoView)
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerImage)
        scrollView.addSubview(stackView)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImage.heightAnchor.constraint(equalToConstant: 300),
            stackView.topAnchor.constraint(equalTo: headerImage.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    // MARK: UI Views
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var headerImage: ImageView = {
        let imageView = ImageView()
        imageView.loadImage(urlString: mission.roverImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var spacerView = UIView(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 24))
    
    private lazy var missionLabel: UILabel = {
        let label = UILabel()
        label.text = mission.missionName
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        return label
    }()
    
}
