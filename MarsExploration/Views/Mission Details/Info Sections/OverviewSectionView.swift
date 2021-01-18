//
//  OverviewSectionView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/18/21.
//

import Foundation
import UIKit

class OverviewSectionView: UIView {
    
    enum OverviewState {
        case short
        case full
    }
    
    private var overviewState: OverviewState = .short {
        didSet {
            // The overview text and button title
            var text: String
            var buttonTitle: String
            
            switch overviewState {
            case .short:
                text = mission.overview
                buttonTitle = "Read more"
            case .full:
                text = mission.fullOverview
                buttonTitle = "Read less"
            }
            
            UIView.transition(
                with: overviewLabel,
                duration: 0.0,
                options: .transitionCrossDissolve,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.overviewLabel.text = text
                    self.readMoreButton.setTitle(buttonTitle, for: .normal)
                }, completion: nil)
        }
    }
    
    // MARK: Initialization
    
    private let mission: Mission
    init(mission: Mission) {
        self.mission = mission
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(stackView)
        addSubview(readMoreButton)
        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(overviewLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            readMoreButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            readMoreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            readMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: Actions
    
    @objc private func readMoreTapped(_ sender: UIButton) {
        if overviewState == .short {
            overviewState = .full
        } else {
            overviewState = .short
        }
    }
    
    // MARK: UI Views
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = mission.overview
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Regular", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var readMoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Read more", for: .normal)
        button.setTitleColor(UIColor(named: "orange"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 16)
        button.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 24, bottom: 8, right: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}
