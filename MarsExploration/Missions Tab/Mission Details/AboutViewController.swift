//
//  AboutViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/21/21.
//
import Foundation
import UIKit

class AboutViewController: UIViewController {

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

        // Set the background color for the view
        view.backgroundColor = UIColor.init(named: "background")

        setupViews()
        setupConstraints()

        populateData()
    }

    // MARK: Populate Data
    
    private func populateData() {
        // Add roverImage to headerView
        headerView.roverImage.image = UIImage(named: mission.roverName.lowercased())

        [spacerView, introSectionView, missionSectionView,
         launchSectionView, landingSectionView, overviewSectionView
        ].forEach { missionDetailsStackView.addArrangedSubview($0) }

        missionDetailsStackView.setCustomSpacing(32, after: introSectionView)
    }

    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(scrollView)

        [headerView, missionDetailsStackView].forEach { scrollView.addSubview($0) }
    }

    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            missionDetailsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            missionDetailsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            missionDetailsStackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            missionDetailsStackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }

    // MARK: UI Views
    
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

    private lazy var introSectionView = IntroSectionView(mission: mission)
    private lazy var missionSectionView = MissionSectionView(mission: mission)
    private lazy var launchSectionView = LaunchSectionView(mission: mission)
    private lazy var landingSectionView = LandingSectionView(mission: mission)
    private lazy var overviewSectionView = OverviewSectionView(mission: mission)
}
