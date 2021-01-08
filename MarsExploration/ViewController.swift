//
//  ViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }

    // MARK: Setup Views
        
    private func setupViews() {
        view.addSubview(titleLabel)
    }

    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Mars"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
