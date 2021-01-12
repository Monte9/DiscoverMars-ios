//
//  PhotosSectionView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/10/21.
//

import Foundation
import UIKit

class PhotosSectionView: UIView {
    
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
        addSubview(headerLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: UI Views
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Futura-Medium", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
