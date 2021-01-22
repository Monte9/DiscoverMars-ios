//
//  SectionRow.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/18/21.
//

import Foundation
import UIKit

class SectionRow: UIView {
    
    // MARK: Initialization
    
    private let title: String
    private let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            valueLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width * 0.7),
        ])
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(dividerLine)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            dividerLine.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 16),
            dividerLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: UI Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = value
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.layer.opacity = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(named: "orange")?.cgColor
        view.layer.opacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
