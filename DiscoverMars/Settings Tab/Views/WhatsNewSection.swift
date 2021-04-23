//
//  WhatsNewSection.swift
//  DiscoverMars
//
//  Created by Monte Thakkar on 4/23/21.
//

import UIKit

class WhatsNewSection: UIStackView {
    
    var isLastSection: Bool = false {
        didSet {
            if isLastSection {
                removeArrangedSubview(dividerLine)
            } else {
                addArrangedSubview(dividerLine)
            }
        }
    }
    
    // MARK: Initialization
    
    private let section: WhatsNew
    
    init(section: WhatsNew) {
        self.section = section
        
        super.init(frame: .zero)
        
        axis = .vertical
        spacing = 16
        
        if section.type == .summaryOnly {
            addArrangedSubview(summaryLabel)
            addArrangedSubview(dividerLine)
            
            summaryLabel.text = section.summary
            return
        }
        
        setupViews()
        
        numberLabel.text = section.number
        titleLabel.text = section.title
        summaryLabel.text = section.summary
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addArrangedSubview(numberLabel)
        addArrangedSubview(titleLabel)
        addArrangedSubview(summaryLabel)
        addArrangedSubview(dividerLine)
        
        setCustomSpacing(4, after: numberLabel)
    }
    
    // MARK: UI Views
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.opacity = 0.5
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Medium", size: 24)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange")
        label.font = UIFont(name: "Inter-Bold", size: 24)
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
