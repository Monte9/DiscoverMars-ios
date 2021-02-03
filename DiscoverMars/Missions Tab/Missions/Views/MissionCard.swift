//
//  MissionCard.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import Foundation
import UIKit

class MissionCard: UIControl {
    
    // MARK: Initialization
    
    let mission: Mission
    
    init(for mission: Mission) {
        self.mission = mission
        super.init(frame: .zero)
        
        // Add drop shadow effect to the background
        backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 20
        
        // Adds border radius
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "light")?.cgColor
        
        // Adds corder radius
        layer.cornerRadius = 20
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor(named: "light")?.cgColor
        
        NSLayoutConstraint.activate([
            roverImage.widthAnchor.constraint(equalToConstant: frame.width * 0.8),
            roverImage.heightAnchor.constraint(equalToConstant: frame.height * 0.8),
            roverImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: frame.width/6.7),
        ])
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(bottomView)
        containerView.addSubview(roverImage)
        containerView.addSubview(roverLabel)
        containerView.addSubview(missionLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            roverLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            roverLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            roverLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -24),
            missionLabel.topAnchor.constraint(equalTo: roverLabel.bottomAnchor, constant: 4),
            missionLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -24),
            missionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            missionLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -24),
            roverImage.bottomAnchor.constraint(equalTo: missionLabel.topAnchor, constant: 20)
        ])
    }
    
    // MARK: UI Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = bounds
        view.backgroundColor = UIColor(named: "color.10")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "color.100")
        view.clipsToBounds = true
        view.layer.cornerRadius = 16.0
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let roverLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 30)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let missionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roverImage: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
}
