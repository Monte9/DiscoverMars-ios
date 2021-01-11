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
        
        // Adds the shadow effect to the backgrond
        backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 20
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(bottomView)
        containerView.addSubview(roverLabel)
        containerView.addSubview(roverImage)
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
            bottomView.heightAnchor.constraint(equalToConstant: 83),
            roverLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            roverLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            roverImage.heightAnchor.constraint(equalToConstant: 217),
            roverImage.widthAnchor.constraint(equalToConstant: 361),
            roverImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            roverImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 55),
        ])
    }
    
    // MARK: UI Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = bounds
        view.backgroundColor = UIColor(named: "orange")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "orange.light")
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
        label.textColor = UIColor(named: "cream")
        label.font = UIFont(name: "Futura-Medium", size: 36)
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
