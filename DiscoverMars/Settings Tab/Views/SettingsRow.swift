//
//  SettingsRow.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/5/21.
//

import Foundation
import UIKit

class SettingsRow: UIControl {
    
    var shouldDisplaySubtitle: Bool = false {
        didSet {
            updateSubtitleLabel()
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Adds border color and corder radius
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "background")?.cgColor
        layer.cornerRadius = 20
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor(named: "background")?.cgColor
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24)
        ])
    }
    
    private func updateSubtitleLabel() {
        if shouldDisplaySubtitle {
            containerView.addSubview(subtitleLabel)
            
            NSLayoutConstraint.activate([
                subtitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
                subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
                subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
                subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            ])
        }
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .red
        label.sizeToFit()
        label.textColor = UIColor(named: "background")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .blue
        label.textColor = UIColor(named: "background")
        label.layer.opacity = 0.6
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
