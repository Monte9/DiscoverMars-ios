//
//  HeaderView.swift
//  MarsExploration
//
//  Created by Monte Thakkar on 1/13/21.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "orange")
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            roverImage.widthAnchor.constraint(equalToConstant: readableContentGuide.layoutFrame.width * 0.9),
            roverImage.heightAnchor.constraint(equalToConstant: readableContentGuide.layoutFrame.height * 0.9),
            roverImage.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: readableContentGuide.layoutFrame.width/6.7),
        ])
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(bottomView)
        addSubview(roverImage)
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.isIpad ? 300 : 200),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 75),
            roverImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: UI Views
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "orange.light")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let roverImage: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
