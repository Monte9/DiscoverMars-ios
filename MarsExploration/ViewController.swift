//
//  ViewController.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Constants
    
    // You can start using this key to make web service requests. Simply pass your key in the URL when making a web request.
    // Here's an example: https://api.nasa.gov/planetary/apod?api_key=maiBleq3ql7plddEDkigXNisbFgXdMBpdCjLgGIO
    private let NASA_API_KEY = "maiBleq3ql7plddEDkigXNisbFgXdMBpdCjLgGIO"

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
        let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=maiBleq3ql7plddEDkigXNisbFgXdMBpdCjLgGIO")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }

            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
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
