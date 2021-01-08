//
//  ViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "background")
        
        fetchData()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: Network Requests
        
    private func fetchData() {
        NetworkManager.shared.fetchManifest(for: .spirit) { result in
            switch result {
            case .success(let mission):
                print(mission.name)
                print("Success!")
            case .failure(let error):
                print("Failed to fetch mission manifest: \(error)")
            }
        }
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
        label.textColor = UIColor.init(named: "text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
