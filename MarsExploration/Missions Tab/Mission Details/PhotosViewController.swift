//
//  PhotosViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/22/21.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {

    // MARK: Initialization
    
    private let mission: Mission
    init(for mission: Mission) {
        self.mission = mission
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background color for the view
        view.backgroundColor = UIColor.init(named: "background")

        setupViews()
        setupConstraints()
    }

    // MARK: Setup Views
    
    private func setupViews() {
        view.addSubview(label)
    }

    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: UI Views
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
