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
        
        // only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = bounds
            blurEffectView.alpha = 0.8
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            addSubview(blurEffectView)
        }
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(roverImage)
        addSubview(missionLabel)
        addSubview(roverLabel)
        
        sendSubviewToBack(roverImage)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roverImage.topAnchor.constraint(equalTo: topAnchor),
            roverImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            roverImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            roverImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            missionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            missionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            missionLabel.bottomAnchor.constraint(equalTo: roverLabel.topAnchor, constant: -8),
            roverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            roverLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            roverLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: UI Components
    
    let roverImage: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let missionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roverLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
