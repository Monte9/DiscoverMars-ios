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
        
        [spacerView, aboutSectionView, missionSectionView,
         launchSectionView, landingSectionView, overviewSectionView, dividerLine
        ].forEach { missionDetailsStackView.addArrangedSubview($0) }
        
        missionDetailsStackView.setCustomSpacing(32, after: aboutSectionView)
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(backButton)
        view.addSubview(scrollView)
        
        [headerView, missionDetailsStackView, dividerLine, photosSectionView].forEach { scrollView.addSubview($0) }
        
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
            missionDetailsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            missionDetailsStackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            missionDetailsStackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            photosSectionView.topAnchor.constraint(equalTo: missionDetailsStackView.bottomAnchor, constant: 24),
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
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.layer.cornerRadius = 24
        button.backgroundColor = UIColor(named: "background")
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Setup Back Icon Image
        let backIcon = UIImage(systemName:"chevron.left")?.withRenderingMode(.alwaysTemplate)
        button.setImage(backIcon, for: .normal)
        button.tintColor = UIColor(named: "orange")
        
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
    
    private let missionDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var spacerView = UIView(frame: CGRect(x: 0, y: 0, width: missionDetailsStackView.frame.width, height: 24))
    
    private lazy var aboutSectionView = AboutSectionView(mission: mission)
    private lazy var missionSectionView = MissionSectionView(mission: mission)
    private lazy var launchSectionView = LaunchSectionView(mission: mission)
    private lazy var landingSectionView = LandingSectionView(mission: mission)
    private lazy var overviewSectionView = OverviewSectionView(mission: mission)
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(named: "orange")?.cgColor
        view.layer.opacity = 0.1
        return view
    }()
    
    private let photosSectionView: PhotosSectionView = {
        let view = PhotosSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
