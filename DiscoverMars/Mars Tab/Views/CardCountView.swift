//
//  CardCountView.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 2/8/21.
//

import Foundation
import UIKit

class CardCountView: UIView {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Adds border and corder radius
        clipsToBounds = true
        layer.borderWidth = 0.4
        layer.borderColor = UIColor(named: "background")?.withAlphaComponent(0.6).cgColor
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMaxYCorner]
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor(named: "background")?.withAlphaComponent(0.6).cgColor
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(countLabel)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    // MARK: UI Views
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "background")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
