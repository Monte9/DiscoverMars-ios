//
//  MissionDetailsViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/9/21.
//

import Foundation
import UIKit

class MissionDetailsViewController: UIViewController {
    
    private weak var defaultGestureRecognizerDelegate: UIGestureRecognizerDelegate?
    private var customPopRecognizer: InteractivePopRecognizer?
    
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
        
        // Set the background color for the status bar
        navigationController?.setStatusBar(backgroundColor: UIColor(named: "orange"))
        
        // Set the background color for the view
        view.backgroundColor = UIColor.init(named: "background")
        
        setupViews()
        setupConstraints()
        
        populateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Enable swipe back gesture from child VC to root VC
        if let navigationController = navigationController {
            // Saves the default gestureRecognizerDelegate of the UINavigationController so it can be restored later
            defaultGestureRecognizerDelegate = navigationController.interactivePopGestureRecognizer?.delegate

            // Set the custom gestureRecognizerDelegate on the UINavigationController to enable swipe back gesture for RN Screens
            customPopRecognizer = InteractivePopRecognizer(navController: navigationController)
            navigationController.interactivePopGestureRecognizer?.delegate = customPopRecognizer
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore the default gestureRecognizerDelegate on the UINavigationController
        navigationController?.interactivePopGestureRecognizer?.delegate = defaultGestureRecognizerDelegate
    }
    
    // MARK: Populate Data
    
    private func populateData() {
        // Add roverImage to headerView
        headerView.roverImage.image = UIImage(named: mission.roverName.lowercased())
        
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
        view.addSubview(backButton)
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(photosSectionView)
        
        view.bringSubviewToFront(backButton)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            photosSectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            photosSectionView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            photosSectionView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            photosSectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    // MARK: Actions
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: UI Views
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(named: "orange.light")
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Setup Back Icon Image
        let backIcon = UIImage(systemName:"chevron.left")?.withRenderingMode(.alwaysTemplate)
        button.setImage(backIcon, for: .normal)
        button.tintColor = UIColor(named: "text")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.font = UIFont(name: "Futura-Medium", size: 26)
        return label
    }()
    
    private let photosSectionView: PhotosSectionView = {
        let view = PhotosSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
