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
        
        // Setup tap animation by default
        setupAnimations()
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
        containerView.addSubview(openLinkImage)
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
                subtitleLabel.leadingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
                openLinkImage.leadingAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.trailingAnchor, constant: 8),
            ])
        } else {
            NSLayoutConstraint.activate([
                openLinkImage.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
            ])
        }
        
        NSLayoutConstraint.activate([
            openLinkImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            openLinkImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            openLinkImage.widthAnchor.constraint(equalToConstant: 8),
            openLinkImage.heightAnchor.constraint(equalToConstant: 8),
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "background")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "background")
        label.layer.opacity = 0.6
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let openLinkImage: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "open.link")?.withTintColor(UIColor(named: "background") ?? .white)
        return imageView
    }()
}
