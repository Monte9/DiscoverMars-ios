//
//  MissionCard.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import Foundation
import UIKit

class MissionCard: UIView {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 10.0
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(missionLabel)
        addSubview(roverLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            missionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            missionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            roverLabel.topAnchor.constraint(equalTo: missionLabel.bottomAnchor, constant: 10),
            roverLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    // MARK: UI Components
    
    let missionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.init(named: "text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roverLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.init(named: "text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
