//
//  IntroSectionView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/15/21.
//

import Foundation
import UIKit

class IntroSectionView: UIView {
    
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
        addSubview(roverLabel)
        addSubview(missionLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roverLabel.topAnchor.constraint(equalTo: topAnchor),
            roverLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            roverLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            missionLabel.topAnchor.constraint(equalTo: roverLabel.bottomAnchor, constant: 8),
            missionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            missionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            missionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: UI Views
    
    private lazy var roverLabel: UILabel = {
        let label = UILabel()
        label.text = mission.roverName
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Bold", size: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var missionLabel: UILabel = {
        let label = UILabel()
        label.text = mission.missionName
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.layer.opacity = 0.6
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
