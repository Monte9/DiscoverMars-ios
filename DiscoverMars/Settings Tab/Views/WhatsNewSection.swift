//
//  WhatsNewSection.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/23/21.
//

import UIKit

class WhatsNewSection: UIStackView {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        spacing = 16
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addArrangedSubview(sectionNumber)
        addArrangedSubview(titleLabel)
        addArrangedSubview(summaryLabel)
        addArrangedSubview(dividerLine)
        
        setCustomSpacing(4, after: sectionNumber)
    }
    
    // MARK: UI Views
    
    let sectionNumber: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "01"
        label.layer.opacity = 0.5
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 24)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Custom Icons"
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Bold", size: 24)
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Here’s a quick digest of some of the changes in Version 1.09.10 that we wanted you to know about beyond bug fixes and performance improvements."
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Regular", size: 18)
        return label
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(named: "orange")?.cgColor
        view.layer.opacity = 0.5
        return view
    }()
}
