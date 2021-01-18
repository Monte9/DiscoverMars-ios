//
//  SectionView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/18/21.
//

import Foundation
import UIKit

class SectionView: UIView {
    
    // MARK: Initialization
    private let title: String
    private let rows: [UIView]
    
    init(title: String, rows: [UIView]) {
        self.title = title
        self.rows = rows
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
        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(dividerLine)
        
        rows.forEach { stackView.addArrangedSubview($0) }
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: UI Views
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textColor = UIColor(named: "text")
        label.font = UIFont(name: "Inter-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(named: "orange")?.cgColor
        view.layer.opacity = 0.1
        return view
    }()
    
}
