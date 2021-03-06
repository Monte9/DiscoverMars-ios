//
//  NavigationHeaderView.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 3/5/21.
//

import Foundation
import UIKit

class NavigationHeaderView: UIView {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(rightIconButton)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightIconButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightIconButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: UI Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover Mars"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "background")
        label.font = UIFont(name: "Inter-Medium", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightIconButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "background")
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "exclamationmark.bubble.fill", withConfiguration: largeConfiguration)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
