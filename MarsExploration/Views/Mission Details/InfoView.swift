//
//  InfoView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/10/21.
//

import Foundation
import UIKit

class InfoView: UIView {
    
    // MARK: Initialization
    
    private let title: String
    private let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(stackView)
        
        [titleLabel, subtitleLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: UI Views
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = .systemFont(ofSize: 16, weight: .black)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = subtitle
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
}
